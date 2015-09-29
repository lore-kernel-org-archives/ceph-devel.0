From: Andrew Woodward <xarses-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [puppet] Moving puppet-ceph to the Openstack big
	tent
Date: Tue, 29 Sep 2015 21:45:54 +0000
Message-ID: <CACEfbZjcC7AR3SXNrepxM=KAX64WXCtGxeHhnOKQ-PmCZU73gg@mail.gmail.com>
References: <CAH7C+Pr2rA65O8gm3B1A64fFPctb_-q=jE=a6AHKJcfHNY1OEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076583881=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAH7C+Pr2rA65O8gm3B1A64fFPctb_-q=jE=a6AHKJcfHNY1OEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Moreau Simard <dms-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph User Committee <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1076583881==
Content-Type: multipart/alternative; boundary=001a114084e69ef9800520e9bdf9

--001a114084e69ef9800520e9bdf9
Content-Type: text/plain; charset=UTF-8

[I'm cross posting this to the other Ceph threads to ensure that it's seen]

We've discussed this on Monday on IRC and again in the puppet-openstack IRC
meeting. The current census is that we will move from the deprecated
stackforge organization and will be moved to the openstack one. At this
time we will not be perusing membership as a formal OpenStack project. This
will allow puppet-ceph to retain the tight relationship with OpenStack
community and tools for the time being.

On Mon, Sep 28, 2015 at 8:32 AM David Moreau Simard <dms-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi,
>
> puppet-ceph currently lives in stackforge [1] which is being retired
> [2]. puppet-ceph is also mirrored on the Ceph Github organization [3].
> This version of the puppet-ceph module was created from scratch and
> not as a fork of the (then) upstream puppet-ceph by Enovance [4].
> Today, the version by Enovance is no longer officially maintained
> since Red Hat has adopted the new release.
>
> Being an Openstack project under Stackforge or Openstack brings a lot
> of benefits but it's not black and white, there are cons too.
>
> It provides us with the tools, the processes and the frameworks to
> review and test each contribution to ensure we ship a module that is
> stable and is held to the highest standards.
> But it also means that:
> - We forego some level of ownership back to the Openstack foundation,
> it's technical committee and the Puppet Openstack PTL.
> - puppet-ceph contributors will also be required to sign the
> Contributors License Agreement and jump through the Gerrit hoops [5]
> which can make contributing to the project harder.
>
> We have put tremendous efforts into creating a quality module and as
> such it was the first puppet module in the stackforge organization to
> implement not only unit tests but also integration tests with third
> party CI.
> Integration testing for other puppet modules are just now starting to
> take shape by using the Openstack CI inrastructure.
>
> In the context of Openstack, RDO already ships with a mean to install
> Ceph with this very module and Fuel will be adopting it soon as well.
> This means the module will benefit from real world experience and
> improvements by the Openstack community and packagers.
> This will help further reinforce that not only Ceph is the best
> unified storage solution for Openstack but that we have means to
> deploy it in the real world easily.
>
> We all know that Ceph is also deployed outside of this context and
> this is why the core reviewers make sure that contributions remain
> generic and usable outside of this use case.
>
> Today, the core members of the project discussed whether or not we
> should move puppet-ceph to the Openstack big tent and we had a
> consensus approving the move.
> We would also like to hear the thoughts of the community on this topic.
>
> Please let us know what you think.
>
> Thanks,
>
> [1]: https://github.com/stackforge/puppet-ceph
> [2]: https://review.openstack.org/#/c/192016/
> [3]: https://github.com/ceph/puppet-ceph
> [4]: https://github.com/redhat-cip/puppet-ceph
> [5]: https://wiki.openstack.org/wiki/How_To_Contribute
>
> David Moreau Simard
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-- 

--

Andrew Woodward

Mirantis

Fuel Community Ambassador

Ceph Community

--001a114084e69ef9800520e9bdf9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[I&#39;m cross posting this to the other Ceph threads to e=
nsure that it&#39;s seen]<div><br></div><div>We&#39;ve discussed this on Mo=
nday on IRC and again in the puppet-openstack IRC meeting. The current cens=
us is that we will move from the deprecated stackforge organization and wil=
l be moved to the openstack one. At this time we will not be perusing membe=
rship as a formal OpenStack project. This will allow puppet-ceph to retain =
the tight relationship with OpenStack community and tools for the time bein=
g.=C2=A0<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Sep 28,=
 2015 at 8:32 AM David Moreau Simard &lt;<a href=3D"mailto:dms-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
dms-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<b=
r>
<br>
puppet-ceph currently lives in stackforge [1] which is being retired<br>
[2]. puppet-ceph is also mirrored on the Ceph Github organization [3].<br>
This version of the puppet-ceph module was created from scratch and<br>
not as a fork of the (then) upstream puppet-ceph by Enovance [4].<br>
Today, the version by Enovance is no longer officially maintained<br>
since Red Hat has adopted the new release.<br>
<br>
Being an Openstack project under Stackforge or Openstack brings a lot<br>
of benefits but it&#39;s not black and white, there are cons too.<br>
<br>
It provides us with the tools, the processes and the frameworks to<br>
review and test each contribution to ensure we ship a module that is<br>
stable and is held to the highest standards.<br>
But it also means that:<br>
- We forego some level of ownership back to the Openstack foundation,<br>
it&#39;s technical committee and the Puppet Openstack PTL.<br>
- puppet-ceph contributors will also be required to sign the<br>
Contributors License Agreement and jump through the Gerrit hoops [5]<br>
which can make contributing to the project harder.<br>
<br>
We have put tremendous efforts into creating a quality module and as<br>
such it was the first puppet module in the stackforge organization to<br>
implement not only unit tests but also integration tests with third<br>
party CI.<br>
Integration testing for other puppet modules are just now starting to<br>
take shape by using the Openstack CI inrastructure.<br>
<br>
In the context of Openstack, RDO already ships with a mean to install<br>
Ceph with this very module and Fuel will be adopting it soon as well.<br>
This means the module will benefit from real world experience and<br>
improvements by the Openstack community and packagers.<br>
This will help further reinforce that not only Ceph is the best<br>
unified storage solution for Openstack but that we have means to<br>
deploy it in the real world easily.<br>
<br>
We all know that Ceph is also deployed outside of this context and<br>
this is why the core reviewers make sure that contributions remain<br>
generic and usable outside of this use case.<br>
<br>
Today, the core members of the project discussed whether or not we<br>
should move puppet-ceph to the Openstack big tent and we had a<br>
consensus approving the move.<br>
We would also like to hear the thoughts of the community on this topic.<br>
<br>
Please let us know what you think.<br>
<br>
Thanks,<br>
<br>
[1]: <a href=3D"https://github.com/stackforge/puppet-ceph" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/stackforge/puppet-ceph</a><br>
[2]: <a href=3D"https://review.openstack.org/#/c/192016/" rel=3D"noreferrer=
" target=3D"_blank">https://review.openstack.org/#/c/192016/</a><br>
[3]: <a href=3D"https://github.com/ceph/puppet-ceph" rel=3D"noreferrer" tar=
get=3D"_blank">https://github.com/ceph/puppet-ceph</a><br>
[4]: <a href=3D"https://github.com/redhat-cip/puppet-ceph" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/redhat-cip/puppet-ceph</a><br>
[5]: <a href=3D"https://wiki.openstack.org/wiki/How_To_Contribute" rel=3D"n=
oreferrer" target=3D"_blank">https://wiki.openstack.org/wiki/How_To_Contrib=
ute</a><br>
<br>
David Moreau Simard<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div></div></div><div dir=3D"ltr">-- <br></div><div dir=3D"lt=
r"><p dir=3D"ltr">--</p><p dir=3D"ltr"><span style=3D"font-size:13.19999980=
92651px">Andrew Woodward</span></p><p dir=3D"ltr"><span style=3D"font-size:=
13.1999998092651px">Mirantis</span></p><p dir=3D"ltr"><span style=3D"font-s=
ize:13.1999998092651px">Fuel Community Ambassador</span></p><p dir=3D"ltr">=
<span style=3D"font-size:13.1999998092651px">Ceph Community</span></p>
</div>

--001a114084e69ef9800520e9bdf9--

--===============1076583881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1076583881==--
