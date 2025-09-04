import Component from '@glimmer/component';
import { service } from '@ember/service';
import { schedule } from '@ember/runloop';

export class NonLoginContainer extends Component {
	@service router;

	constructor() {
		super(...arguments);
		schedule('afterRender', () => {
			this.removeSearchBanner();
		});
	}

	get shouldShow() {
		return this.router.currentRouteName === 'discovery.categories' && !this.router.currentUser;
	}

	removeSearchBanner() {
		if(this.shouldShow) {
			const searchBanner = document.querySelector('.above-main-container-outlet.search-banner.welcome-banner');
			if(searchBanner) {
				searchBanner.style.display = 'none';
			}
		}
	}

	<template>
		{{log this.shouldShow}}
		{{#if this.shouldShow}}
				<div class="text-container" style="font-family: 'Roboto', Arial, sans-serif; text-align: left;">
					<div class="content-wrap">
						<div class="banner-text">
							<h1>Empowering Enterprise Application Professionals</h1>
						</div>

						<h2 class="animated-text" role="status" aria-live="polite">
							<span id="typewriter-box">
								<span id="typewriter"></span>
							</span>
						</h2>

						<p class="hero-description">
							<span class="brand-name">EASIHUB</span> is a dedicated forum for Enterprise Software <span class="acronym">(EAS)</span> professionals — developers, consultants, and architects — to discuss topics across enterprise application domains, share technical expertise, and access curated articles, bulletins, events, and job opportunities — enhanced with AI-powered features.
						</p>
					
						<p class="connection-text">
							Connect with experts, discover solutions, and accelerate your professional growth — <span class="ai-highlight">powered by EASIHUB AI</span>.
						</p>

						<div class="button-container" style="display: flex; gap: 10px; font-family: 'Roboto', Arial, sans-serif;"> 
							<button class="btn btn-icon-text btn-primary btn-small login-button" type="button">Join Free</button>
							<button class="btn btn-text btn-primary btn-small sign-up-button" type="button">Login</button>
								<a href="https://easihub.com/start-exploring" class="visit-community" style="display: inline-flex; align-items: center; margin: 0px; padding: 0px 10px; font-family: 'Roboto', Arial, sans-serif; color: #4949fc;" target="_blank" rel="noopener">
								<i class="fa-solid fa-compass" style="margin-right: 6px;"></i>
								<span class="explore-text">Start Exploring</span>
								<i class="fa-solid fa-chevron-right" style="color: #4949fc; margin-left: 6px;"></i>
							</a>
						</div>
					</div>
					<div class="image-container">
						<img src="https://easihub.com/uploads/default/original/1X/370bcb681a541964b0f06fe12a9bc816c65750eb.png" alt="Group of people" height="70%" width="100%"/>
					</div>
				</div>
				<div class="text-center mt-2 w-full">
					<span class="text-gray-600 font-semibold p-1 mb-2">Why teams choose EASIHUB</span>
				</div>
				<div class="usp-highlights">
					<!-- Card 1 -->
					<article class="usp-card" aria-labelledby="usp1-title">
							<div class="usp-head">
									<div class="usp-icon" aria-hidden="true">💡</div>
									<div>
											<h3 id="usp1-title" class="usp-title">Targeted Enterprise Q&amp;A</h3>
											<p class="usp-desc">Fast answers by domain → software hubs.</p>
									</div>
							</div>
							<ul class="usp-list">
									<li>ERP · CRM · PLM · MES · Cloud</li>
									<li>SAP · Salesforce · Oracle · Teamcenter</li>
									<li>Config, integration, APIs (REST/OData)</li>
							</ul>
					</article>

					<!-- Card 2 -->
					<article class="usp-card" aria-labelledby="usp2-title">
							<div class="usp-head">
									<div class="usp-icon" aria-hidden="true">🧠</div>
									<div>
											<h3 id="usp2-title" class="usp-title">Expert‑Verified Playbooks</h3>
											<p class="usp-desc">Vendor‑neutral best practices &amp; patterns.</p>
									</div>
							</div>
							<ul class="usp-list">
									<li>Reference architectures &amp; security</li>
									<li>Code snippets: ABAP, Apex, JS/Node</li>
									<li>Cross‑platform comparisons</li>
							</ul>
					</article>

					<!-- Card 3 -->
					<article class="usp-card" aria-labelledby="usp3-title">
							<div class="usp-head">
									<div class="usp-icon" aria-hidden="true">💼</div>
									<div>
											<h3 id="usp3-title" class="usp-title">Careers Matched to Your Stack</h3>
											<p class="usp-desc">Jobs &amp; gigs tied to skills and software.</p>
									</div>
							</div>
							<ul class="usp-list">
									<li>Roles for SAP, Salesforce, Oracle</li>
									<li>Portfolio via answers &amp; use cases</li>
									<li>Smart tag matching (domain, skill)</li>
							</ul>
					</article>
			</div>
		{{/if}}
	</template>
}

export default NonLoginContainer;