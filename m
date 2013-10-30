From: Bernard Grymonpon <bernard-sbM3GJIWwA3bB1ukUYwELw@public.gmane.org>
Subject: Re: Inktank Ceph Enterprise Launch
Date: Wed, 30 Oct 2013 19:56:49 +0100
Message-ID: <F8544FDE-CB2B-4AE7-A389-3D2BBC0D9310@openminds.be>
References: <CAP8Oy=+CfOLQZq3X02zrE6sCLyJ_wKxiLeKX8v=PmpZQ3d_0QA@mail.gmail.com>
	<527141E3.2020601@dachary.org>
	<57ED724085B72141BB091CF1314E471F017A605A@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <57ED724085B72141BB091CF1314E471F017A605A-nsZYYkk5h5Q0nt+34NmQpKBKnGwkPULj@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

The only thing that would be needed would be a good plugin/addon/agent to g=
raphite, collectd, snmpd or anything along these lines, giving the correct =
metrics that identify the performance and status of the platform, well docu=
mented. =


Dashboards are up to the users themselfs (although a good example is most w=
elcome in most situations).

On 30 Oct 2013, at 19:03, "Don Talton (dotalton)" <dotalton-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org> wrot=
e:

> I actually started a django app (no code pushed yet) for this purpose. I =
guessed that Inktank might come out with a commercial offering and thought =
a FOSS dashboard would be a good thing for the community too.
> =

> https://github.com/dontalton/kraken
> =

> I'd much rather contribute to a Inktank-backed dashboard if it were FOSS,=
 than start a new project.
> =

> =

>> -----Original Message-----
>> From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-
>> bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Loic Dachary
>> Sent: Wednesday, October 30, 2013 10:29 AM
>> To: Patrick McGarry; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; Ceph Devel
>> Subject: Re: [ceph-users] Inktank Ceph Enterprise Launch
>> =

>> Hi Patrick,
>> =

>> I wish Inktank was able to base its strategy and income on Free Software.
>> Like RedHat does, for instance. In addition, as long as Inktank employs =
the
>> majority of Ceph developers, publishing Calamari as a proprietary softwa=
re is
>> a conflict of interest. Should someone from the community bootstrap a Fr=
ee
>> Software alternative to Calamari, it will compete with it. And should In=
ktank
>> employees participate in the development of this alternative, it would be
>> against the best interest of Inktank. If that were not true, there would=
 be no
>> reason to publish Calamari as proprietary software in the first place.
>> =

>> Please reconsider your decision to publish Calamari as a proprietary sof=
tware.
>> =

>> Now is probably the right time to call for the creation of a Ceph founda=
tion.
>> =

>> Cheers
>> =

>> On 30/10/2013 18:01, Patrick McGarry wrote:
>>> Salutations Ceph-ers,
>>> =

>>> As many of you have noticed, Inktank has taken the wraps off the
>>> latest and greatest magic for enterprise customers.  Wanted to share a
>>> few thoughts from a community perspective on Ceph.com and answer any
>>> questions/concerns folks might have.
>>> =

>>> http://ceph.com/community/new-inktank-ceph-enterprise-builds-on-
>> what-m
>>> akes-ceph-great/
>>> =

>>> Just to reiterate, there will be no changes/limitations to Ceph.  All
>>> Inktank contributions to Ceph will continue to be open source and
>>> useable.  If you have any questions feel free to direct them my way.
>>> Thanks.
>>> =

>>> =

>>> Best Regards,
>>> =

>>> Patrick McGarry
>>> Director, Community || Inktank
>>> http://ceph.com  ||  http://inktank.com @scuttlemonkey || @ceph ||
>>> @inktank
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More
>> majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>> =

>> =

>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
> =

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
