using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MVCcodfirst4.Startup))]
namespace MVCcodfirst4
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
