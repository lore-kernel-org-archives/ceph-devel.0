From: "HEWLETT, Paul (Paul)** CTR **" <paul.hewlett-cfy2TCaE7SFv+uJa97DSA9BPR1lH4CV8@public.gmane.org>
Subject: Re: systemd unit files and multiple daemons
Date: Thu, 23 Apr 2015 08:19:32 +0000
Message-ID: <B1C372F943D5614C80F90CC0D60D421048597544@FR711WXCHMBA04.zeu.alcatel-lucent.com>
References: <55381938.7010600@redhat.com>,
	<CAC6JEv_PkZf-5kHEExdOci=S1so3LXp3y39wQ6NFFuraO1W1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC6JEv_PkZf-5kHEExdOci=S1so3LXp3y39wQ6NFFuraO1W1gw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>, Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

What about running multiple clusters on the same host?

There is a separate mail thread about being able to run clusters with different conf files on the same host.
Will the new systemd service scripts cope with this?

Paul Hewlett
Senior Systems Engineer
Velocix, Cambridge
Alcatel-Lucent
t: +44 1223 435893



________________________________________
From: ceph-users [ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] on behalf of Gregory Farnum [greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org]
Sent: 22 April 2015 23:26
To: Ken Dreyer
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] systemd unit files and multiple daemons

On Wed, Apr 22, 2015 at 2:57 PM, Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> I could really use some eyes on the systemd change proposed here:
> http://tracker.ceph.com/issues/11344
>
> Specifically, on bullet #4 there, should we have a single
> "ceph-mon.service" (implying that users should only run one monitor
> daemon per server) or if we should support multiple "ceph-mon@" services
> (implying that users will need to specify additional information when
> starting the service(s)). The version in our tree is "ceph-mon@". James'
> work for Ubuntu Vivid is only "ceph-mon" [2]. Same thing for ceph-mds vs
> ceph-mds@.
>
> I'd prefer to keep Ubuntu downstream the same as Ceph upstream.
>
> What do we want to do for this?
>
> How common is it to run multiple monitor daemons or mds daemons on a
> single host?

For a real deployment, you shouldn't be running multiple monitors on a
single node in the general case. I'm not sure if we want to prohibit
it by policy, but I'd be okay with the idea.
For testing purposes (in ceph-qa-suite or using vstart as a developer)
it's pretty common though, and we probably don't want to have to
rewrite all our tests to change that. I'm not sure that vstart ever
uses the regular init system, but teuthology/ceph-qa-suite obviously
do!

For MDSes, it's probably appropriate/correct to support multiple
daemons on the same host. This can be either a fault tolerance thing,
or just a way of better using multiple cores if you're living on the
(very dangerous) edge.
-Greg
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
