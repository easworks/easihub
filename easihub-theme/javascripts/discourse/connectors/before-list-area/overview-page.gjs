import Component from '@glimmer/component';
import { service } from '@ember/service';
import { and, array, hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import { tracked } from '@glimmer/tracking';

export default class OverviewPage extends Component {
  @service router;
  @service('url-differentiator') urld;
  @service store;
  @tracked questionTopics = [];
  @tracked trendingTopics = [];

  constructor() {
    super(...arguments);
    if (this.isOverviewPage) {
      this.getQuestionTopics();
      this.getTrendingTopics();
    }
  }

  get isOverviewPage() {
    return this.urld.model?.tag?.id === 'overview';
  }

  async getQuestionTopics() {
    try {
      const topicList = await this.store.findFiltered('topicList', {
        filter: 'latest',
        params: { per_page: 3, tags: 'question' }
      });
      this.questionTopics = topicList.topics || [];
    } catch (error) {
      console.error('Error fetching question topics:', error);
      this.questionTopics = [];
    }
  }

  async getTrendingTopics() {
    try {
      const topicList = await this.store.findFiltered('topicList', {
        filter: 'latest',
        params: { per_page: 3 }
      });
      this.trendingTopics = topicList.topics || [];
    } catch (error) {
      console.error('Error fetching trending topics:', error);
      this.trendingTopics = [];
    }
  }

  get latestQuestions() {
    return this.questionTopics;
  }

  get latestTrending() {
    return this.trendingTopics;
  }

  <template>
    {{#if this.isOverviewPage}}
      <div class="overview-custom-page">
        <div class="p-8 bg-white rounded-2xl shadow-md space-y-8 max-w-5xl">
          <div>
            <h2 class="text-3xl font-semibold text-gray-800">Overview</h2>
            <p class="mt-2 text-gray-600">
              Stay informed about live activities across all Hubs within EASIHUB, including key questions,
              trending discussions, recommended answers, and the latest articles. Your comprehensive summary
              of current updates and insights.
            </p>
          </div>

          <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
            <LinkTo @route="tags.showCategory" @models={{array "question"}} class="bg-blue-100 hover:bg-blue-200 p-4 rounded-xl shadow text-blue-900 font-bold transition">Ask Questions</LinkTo>
            <LinkTo @route="tags.showCategory" @models={{array "discussion"}} class="bg-green-100 hover:bg-green-200 p-4 rounded-xl shadow text-green-900 font-bold transition">Discussions</LinkTo>
            <LinkTo @route="tags.showCategory" @models={{array "use-case"}} class="bg-yellow-100 hover:bg-yellow-200 p-4 rounded-xl shadow text-yellow-900 font-bold transition">Use-Cases</LinkTo>
            <LinkTo @route="tags.showCategory" @models={{array "article"}} class="bg-purple-100 hover:bg-purple-200 p-4 rounded-xl shadow text-purple-900 font-bold transition">Articles</LinkTo>
            <LinkTo @route="tags.showCategory" @models={{array "event"}} class="bg-pink-100 hover:bg-pink-200 p-4 rounded-xl shadow text-pink-900 font-bold transition">Events</LinkTo>
            <LinkTo @route="tags.showCategory" @models={{array "job"}} class="bg-indigo-100 hover:bg-indigo-200 p-4 rounded-xl shadow text-indigo-900 font-bold transition">Jobs</LinkTo>
            <LinkTo @route="tags.showCategory" @models={{array "bulletin"}} class="bg-red-100 hover:bg-red-200 p-4 rounded-xl shadow text-red-900 font-bold transition">Bulletins</LinkTo>
          </div>

          <div class="space-y-3">
            <div class="flex justify-between items-center">
              <h3 class="text-xl font-semibold text-gray-800">Can you solve these questions?</h3>
              <LinkTo @route="discovery.latest" @query={{hash tags="question"}} class="text-blue-600 hover:underline text-sm">View all unsolved questions</LinkTo>
            </div>
            <ul class="space-y-2 text-gray-700">
              {{#each this.latestQuestions as |topic|}}
                <li>
                  <LinkTo @route="topic" @models={{array topic.slug topic.id}} class="font-medium hover:text-blue-600">{{topic.title}}</LinkTo>
                  <p class="text-sm text-gray-500">{{#each topic.tags as |tag|}}{{tag}}{{#unless @last}}, {{/unless}}{{/each}}</p>
                </li>
              {{else}}
                <li>
                  <p class="text-sm text-gray-500">No recent questions available.</p>
                </li>
              {{/each}}
            </ul>
          </div>

          <div class="space-y-3">
            <div class="flex justify-between items-center">
              <h3 class="text-xl font-semibold text-gray-800">See what’s trending</h3>
              <LinkTo @route="discovery.top" @query={{hash tags="question"}} class="text-blue-600 hover:underline text-sm">View all trending questions</LinkTo>
            </div>
            <ul class="space-y-2 text-gray-700">
              {{#each this.latestTrending as |topic|}}
                <li>
                  <LinkTo @route="topic" @models={{array topic.slug topic.id}} class="font-medium hover:text-blue-600">{{topic.title}}</LinkTo>
                  <p class="text-sm text-gray-500">{{#each topic.tags as |tag|}}{{tag}}{{#unless @last}}, {{/unless}}{{/each}}</p>
                </li>
              {{else}}
                <li>
                  <p class="text-sm text-gray-500">No trending topics available.</p>
                </li>
              {{/each}}
            </ul>
          </div>

          <div class="space-y-3">
            <div class="flex justify-between items-center">
              <h3 class="text-xl font-semibold text-gray-800">Learn something new</h3>
              <LinkTo @route="tags.showCategory" @models={{array "articles"}} class="text-blue-600 hover:underline text-sm">View all articles</LinkTo>
            </div>
            <p class="text-sm text-gray-500">No topics available.</p>
          </div>
        </div>

      </div>
    {{/if}}
  </template>
}