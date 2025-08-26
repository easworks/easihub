import { CategoryCardComponent } from '../../../components/category-card.gjs';

export default <template>
  {{#each @categories as |category|}}
    <CategoryCardComponent @category={{category}}/>
  {{/each}}
</template>
