From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of
 objects in pool
Date: Sat, 25 Jun 2016 12:07:29 +0900
Message-ID: <20160625120729.25cddd76@batzmaru.gol.ad.jp>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
	<CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
	<D38DCB57.131AE%warren.wang@walmart.com>
	<20160621075856.3ad471d1@batzmaru.gol.ad.jp>
	<CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
	<CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
	<CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
	<D391D1A4.145D6%warren.wang@walmart.com>
	<BL2PR02MB2115BD5C173011A0CB92F964F42D0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<20160624090806.1246b1ff@batzmaru.gol.ad.jp>
	<BL2PR02MB21153E31C8C9206120947A3FF42E0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+e22SdmGJVzJX9+63T41UGsfFcxs9R=xZqniQyTgu-yG=h0cA@mail.gmail.com>
	<D392D6EB.146C6%warren.wang@walmart.com>
	<CA+e22SdyRuVmBqRahz3sgyLSbWFPssj0+7QHcUChBeyM860Z-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:50539 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbcFYDHn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 23:07:43 -0400
In-Reply-To: <CA+e22SdyRuVmBqRahz3sgyLSbWFPssj0+7QHcUChBeyM860Z-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wade Holler <wade.holler@gmail.com>
Cc: Warren Wang - ISD <Warren.Wang@walmart.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Blair Bethwaite <blair.bethwaite@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>


Hello,

On Fri, 24 Jun 2016 15:45:52 -0400 Wade Holler wrote:

> Not reasonable as you say :
>=20
> vm.min_free_kbytes =3D 90112
>
Yeah, my nodes with IB adapters all have that set to at least 512MB, 1G=
B
if they're over 64GB.
=20
> we're in recovery post expansion (48->54 OSDs) right now but free -t =
is:
>=20
> #free -t
>=20
=46ree can be very misleading when it comes to the actual state of thin=
gs
with regards to memory fragmentation.

Take a look at "cat /proc/buddyinfo" and read up on linux memory
fragmentation.
Also this:
https://www.mail-archive.com/ceph-users@lists.ceph.com/msg22214.html

Christian

>               total        used        free      shared  buff/cache
> available
>=20
> Mem:      693097104   378383384    36870080      369292   277843640
> 250931372
>=20
> Swap:       1048572         956     1047616
>=20
> Total:    694145676   378384340    37917696
>=20
>=20
> On Fri, Jun 24, 2016 at 12:24 PM, Warren Wang - ISD
> <Warren.Wang@walmart.com> wrote:
> > Oops, that reminds me, do you have min_free_kbytes set to something
> > reasonable like at least 2-4GB?
> >
> > Warren Wang
> >
> >
> >
> > On 6/24/16, 10:23 AM, "Wade Holler" <wade.holler@gmail.com> wrote:
> >
> >>On the vm.vfs_cace_pressure =3D 1 :   We had this initially and I s=
till
> >>think it is the best choice for most configs.  However with our lar=
ge
> >>memory footprint, vfs_cache_pressure=3D1 increased the likelihood o=
f
> >>hitting an issue where our write response time would double; then a
> >>drop of caches would return response time to normal.  I don't claim=
 to
> >>totally understand this and I only have speculation at the moment.
> >>Again thanks for this suggestion, I do think it is best for boxes t=
hat
> >>don't have very large memory.
> >>
> >>@ Christian - reformatting to btrfs or ext4 is an option in my test
> >>cluster.  I thought about that but needed to sort xfs first. (thats
> >>what production will run right now) You all have helped me do that =
and
> >>thank you again.  I will circle back and test btrfs under the same
> >>conditions.  I suspect that it will behave similarly but it's only =
a
> >>day and half's work or so to test.
> >>
> >>Best Regards,
> >>Wade
> >>
> >>
> >>On Thu, Jun 23, 2016 at 8:09 PM, Somnath Roy <Somnath.Roy@sandisk.c=
om>
> >>wrote:
> >>> Oops , typo , 128 GB :-)...
> >>>
> >>> -----Original Message-----
> >>> From: Christian Balzer [mailto:chibi@gol.com]
> >>> Sent: Thursday, June 23, 2016 5:08 PM
> >>> To: ceph-users@lists.ceph.com
> >>> Cc: Somnath Roy; Warren Wang - ISD; Wade Holler; Blair Bethwaite;
> >>> Ceph
> >>>Development
> >>> Subject: Re: [ceph-users] Dramatic performance drop at certain nu=
mber
> >>>of objects in pool
> >>>
> >>>
> >>> Hello,
> >>>
> >>> On Thu, 23 Jun 2016 22:24:59 +0000 Somnath Roy wrote:
> >>>
> >>>> Or even vm.vfs_cache_pressure =3D 0 if you have sufficient memor=
y to
> >>>> *pin* inode/dentries in memory. We are using that for long now (=
with
> >>>> 128 TB node memory) and it seems helping specially for the rando=
m
> >>>> write workload and saving xattrs read in between.
> >>>>
> >>> 128TB node memory, really?
> >>> Can I have some of those, too? ^o^
> >>> And here I was thinking that Wade's 660GB machines were on the
> >>>excessive side.
> >>>
> >>> There's something to be said (and optimized) when your storage no=
des
> >>>have the same or more RAM as your compute nodes...
> >>>
> >>> As for Warren, well spotted.
> >>> I personally use vm.vfs_cache_pressure =3D 1, this avoids the pot=
ential
> >>>fireworks if your memory is really needed elsewhere, while keeping
> >>>things in memory normally.
> >>>
> >>> Christian
> >>>
> >>>> Thanks & Regards
> >>>> Somnath
> >>>>
> >>>> -----Original Message-----
> >>>> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On
> >>>> Behalf Of Warren Wang - ISD Sent: Thursday, June 23, 2016 3:09 P=
M
> >>>> To: Wade Holler; Blair Bethwaite
> >>>> Cc: Ceph Development; ceph-users@lists.ceph.com
> >>>> Subject: Re: [ceph-users] Dramatic performance drop at certain
> >>>> number of objects in pool
> >>>>
> >>>> vm.vfs_cache_pressure =3D 100
> >>>>
> >>>> Go the other direction on that. You=E6=98=93ll want to keep it l=
ow to help
> >>>> keep inode/dentry info in memory. We use 10, and haven=E6=98=93t=
 had a
> >>>> problem.
> >>>>
> >>>>
> >>>> Warren Wang
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> On 6/22/16, 9:41 PM, "Wade Holler" <wade.holler@gmail.com> wrote=
:
> >>>>
> >>>> >Blairo,
> >>>> >
> >>>> >We'll speak in pre-replication numbers, replication for this po=
ol
> >>>> >is
> >>>>3.
> >>>> >
> >>>> >23.3 Million Objects / OSD
> >>>> >pg_num 2048
> >>>> >16 OSDs / Server
> >>>> >3 Servers
> >>>> >660 GB RAM Total, 179 GB Used (free -t) / Server vm.swappiness =
=3D 1
> >>>> >vm.vfs_cache_pressure =3D 100
> >>>> >
> >>>> >Workload is native librados with python.  ALL 4k objects.
> >>>> >
> >>>> >Best Regards,
> >>>> >Wade
> >>>> >
> >>>> >
> >>>> >On Wed, Jun 22, 2016 at 9:33 PM, Blair Bethwaite
> >>>> ><blair.bethwaite@gmail.com> wrote:
> >>>> >> Wade, good to know.
> >>>> >>
> >>>> >> For the record, what does this work out to roughly per OSD? A=
nd
> >>>> >> how much RAM and how many PGs per OSD do you have?
> >>>> >>
> >>>> >> What's your workload? I wonder whether for certain workloads
> >>>> >> (e.g. RBD) it's better to increase default object size somewh=
at
> >>>> >> before pushing the split/merge up a lot...
> >>>> >>
> >>>> >> Cheers,
> >>>> >>
> >>>> >> On 23 June 2016 at 11:26, Wade Holler <wade.holler@gmail.com>
> >>>> >> wrote:
> >>>> >>> Based on everyones suggestions; The first modification to 50=
 /
> >>>> >>> 16 enabled our config to get to ~645Mill objects before the
> >>>> >>> behavior in question was observed (~330 was the previous
> >>>> >>> ceiling). Subsequent modification to 50 / 24 has enabled us =
to
> >>>> >>> get to 1.1 Billion+
> >>>> >>>
> >>>> >>> Thank you all very much for your support and assistance.
> >>>> >>>
> >>>> >>> Best Regards,
> >>>> >>> Wade
> >>>> >>>
> >>>> >>>
> >>>> >>> On Mon, Jun 20, 2016 at 6:58 PM, Christian Balzer
> >>>> >>> <chibi@gol.com>
> >>>> >>>wrote:
> >>>> >>>>
> >>>> >>>> Hello,
> >>>> >>>>
> >>>> >>>> On Mon, 20 Jun 2016 20:47:32 +0000 Warren Wang - ISD wrote:
> >>>> >>>>
> >>>> >>>>> Sorry, late to the party here. I agree, up the merge and s=
plit
> >>>> >>>>>thresholds. We're as high as 50/12. I chimed in on an RH ti=
cket
> >>>> >>>>>here.
> >>>> >>>>> One of those things you just have to find out as an operat=
or
> >>>> >>>>>since it's  not well documented :(
> >>>> >>>>>
> >>>> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1219974
> >>>> >>>>>
> >>>> >>>>> We have over 200 million objects in this cluster, and it's
> >>>> >>>>> still
> >>>> >>>>>doing  over 15000 write IOPS all day long with 302 spinning
> >>>> >>>>>drives
> >>>> >>>>>+ SATA SSD  journals. Having enough memory and dropping you=
r
> >>>> >>>>>vfs_cache_pressure  should also help.
> >>>> >>>>>
> >>>> >>>> Indeed.
> >>>> >>>>
> >>>> >>>> Since it was asked in that bug report and also my first
> >>>> >>>>suspicion, it  would probably be good time to clarify that i=
t
> >>>> >>>>isn't the splits that cause  the performance degradation, bu=
t
> >>>> >>>>the resulting inflation of dir entries  and exhaustion of SL=
AB
> >>>> >>>>and thus having to go to disk for things that  normally woul=
d
> >>>> >>>>be in
> >>>>memory.
> >>>> >>>>
> >>>> >>>> Looking at Blair's graph from yesterday pretty much makes t=
hat
> >>>> >>>>clear, a  purely split caused degradation should have relent=
ed
> >>>> >>>>much quicker.
> >>>> >>>>
> >>>> >>>>
> >>>> >>>>> Keep in mind that if you change the values, it won't take
> >>>> >>>>> effect immediately. It only merges them back if the direct=
ory
> >>>> >>>>> is under the calculated threshold and a write occurs (mayb=
e a
> >>>> >>>>> read, I forget).
> >>>> >>>>>
> >>>> >>>> If it's a read a plain scrub might do the trick.
> >>>> >>>>
> >>>> >>>> Christian
> >>>> >>>>> Warren
> >>>> >>>>>
> >>>> >>>>>
> >>>> >>>>> From: ceph-users
> >>>> >>>>>
> >>>>
> >>>>>>>>><ceph-users-bounces@lists.ceph.com<mailto:ceph-users-bounces=
@lists.
> >>>> >>>>>cep
> >>>> >>>>>h.com>>
> >>>> >>>>> on behalf of Wade Holler
> >>>> >>>>> <wade.holler@gmail.com<mailto:wade.holler@gmail.com>> Date=
:
> >>>> >>>>>Monday, June  20, 2016 at 2:48 PM To: Blair Bethwaite
> >>>> >>>>><blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com=
>>,
> >>>> >>>>>Wido den  Hollander <wido@42on.com<mailto:wido@42on.com>> C=
c:
> >>>> >>>>>Ceph Development
> >>>> >>>>><ceph-devel@vger.kernel.org<mailto:ceph-devel@vger.kernel.o=
rg>>,
> >>>> >>>>> "ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.co=
m>"
> >>>> >>>>> <ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.co=
m>>
> >>>> >>>>>Subject:
> >>>> >>>>> Re: [ceph-users] Dramatic performance drop at certain numb=
er
> >>>> >>>>> of
> >>>> >>>>>objects  in pool
> >>>> >>>>>
> >>>> >>>>> Thanks everyone for your replies.  I sincerely appreciate =
it.
> >>>> >>>>> We are testing with different pg_num and
> >>>> >>>>> filestore_split_multiple settings. Early indications are .=
=2E..
> >>>> >>>>> well not great. Regardless it is nice to understand the
> >>>> >>>>> symptoms better so we try to design around it.
> >>>> >>>>>
> >>>> >>>>> Best Regards,
> >>>> >>>>> Wade
> >>>> >>>>>
> >>>> >>>>>
> >>>> >>>>> On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite
> >>>> >>>>><blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com=
>>
> >>>>wrote:
> >>>> >>>>>On
> >>>> >>>>> 20 June 2016 at 09:21, Blair Bethwaite
> >>>> >>>>><blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com=
>>
> >>>>wrote:
> >>>> >>>>> > slow request issues). If you watch your xfs stats you'll
> >>>> >>>>> > likely get further confirmation. In my experience
> >>>> >>>>> > xs_dir_lookups balloons
> >>>> >>>>>(which
> >>>> >>>>> > means directory lookups are missing cache and going to
> >>>> >>>>> > disk).
> >>>> >>>>>
> >>>> >>>>> Murphy's a bitch. Today we upgraded a cluster to latest Ha=
mmer
> >>>> >>>>> in preparation for Jewel/RHCS2. Turns out when we last hit
> >>>> >>>>> this very problem we had only ephemerally set the new
> >>>> >>>>> filestore merge/split values - oops. Here's what started
> >>>> >>>>> happening when we upgraded and restarted a bunch of OSDs:
> >>>> >>>>>
> >>>> >>>>>https://au-east.erc.monash.edu.au/swift/v1/public/grafana-c=
eph-xs
> >>>> >>>>>_d
> >>>> >>>>>ir_
> >>>> >>>>>lookup.png
> >>>> >>>>>
> >>>> >>>>> Seemed to cause lots of slow requests :-/. We corrected it
> >>>> >>>>> about 12:30, then still took a while to settle.
> >>>> >>>>>
> >>>> >>>>> --
> >>>> >>>>> Cheers,
> >>>> >>>>> ~Blairo
> >>>> >>>>>
> >>>> >>>>> This email and any files transmitted with it are confident=
ial
> >>>> >>>>>and intended solely for the individual or entity to whom th=
ey
> >>>> >>>>>are addressed.
> >>>> >>>>> If you have received this email in error destroy it
> >>>> >>>>> immediately.
> >>>> >>>>>***  Walmart Confidential ***
> >>>> >>>>
> >>>> >>>>
> >>>> >>>> --
> >>>> >>>> Christian Balzer        Network/Systems Engineer
> >>>> >>>> chibi@gol.com           Global OnLine Japan/Rakuten
> >>>> >>>> Communications http://www.gol.com/
> >>>> >>
> >>>> >>
> >>>> >>
> >>>> >> --
> >>>> >> Cheers,
> >>>> >> ~Blairo
> >>>>
> >>>> This email and any files transmitted with it are confidential an=
d
> >>>> intended solely for the individual or entity to whom they are
> >>>>addressed.
> >>>> If you have received this email in error destroy it immediately.=
 ***
> >>>> Walmart Confidential ***
> >>>> _______________________________________________
> >>>> ceph-users mailing list ceph-users@lists.ceph.com
> >>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com PLEASE NO=
TE:
> >>>> The information contained in this electronic mail message is
> >>>> intended only for the use of the designated recipient(s) named
> >>>> above. If the reader of this message is not the intended recipie=
nt,
> >>>> you are hereby notified that you have received this message in
> >>>> error and that any review, dissemination, distribution, or copyi=
ng
> >>>> of this message is strictly prohibited. If you have received thi=
s
> >>>> communication in error, please notify the sender by telephone or
> >>>> e-mail (as shown above) immediately and destroy any and all copi=
es
> >>>> of this message in your possession (whether hard copies or
> >>>> electronically stored copies).
> >>>> _______________________________________________ ceph-users maili=
ng
> >>>> list ceph-users@lists.ceph.com
> >>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>
> >>>
> >>>
> >>> --
> >>> Christian Balzer        Network/Systems Engineer
> >>> chibi@gol.com   Global OnLine Japan/Rakuten Communications
> >>> http://www.gol.com/
> >>> PLEASE NOTE: The information contained in this electronic mail
> >>> message
> >>>is intended only for the use of the designated recipient(s) named
> >>>above. If the reader of this message is not the intended recipient=
,
> >>>you are hereby notified that you have received this message in err=
or
> >>>and that any review, dissemination, distribution, or copying of th=
is
> >>>message is strictly prohibited. If you have received this
> >>>communication in error, please notify the sender by telephone or
> >>>e-mail (as shown above) immediately and destroy any and all copies=
 of
> >>>this message in your possession (whether hard copies or
> >>>electronically stored copies).
> >
> >
> > This email and any files transmitted with it are confidential and
> > intended solely for the individual or entity to whom they are
> > addressed. If you have received this email in error destroy it
> > immediately. *** Walmart Confidential ***
>=20


--=20
Christian Balzer        Network/Systems Engineer               =20
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
