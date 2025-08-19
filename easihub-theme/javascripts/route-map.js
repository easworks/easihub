export default function () {
  console.log(this);

  this.route('about-us', { path: '/about-us-2' });
  this.route('code-of-conduct', { path: '/code-of-conduct-2' });
}