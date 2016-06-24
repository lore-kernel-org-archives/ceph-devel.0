From: Wade Holler <wade.holler@gmail.com>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of
 objects in pool
Date: Fri, 24 Jun 2016 10:23:26 -0400
Message-ID: <CA+e22SdmGJVzJX9+63T41UGsfFcxs9R=xZqniQyTgu-yG=h0cA@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl> <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
 <CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
 <CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
 <D38DCB57.131AE%warren.wang@walmart.com> <20160621075856.3ad471d1@batzmaru.gol.ad.jp>
 <CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
 <CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
 <CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
 <D391D1A4.145D6%warren.wang@walmart.com> <BL2PR02MB2115BD5C173011A0CB92F964F42D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <20160624090806.1246b1ff@batzmaru.gol.ad.jp> <BL2PR02MB21153E31C8C9206120947A3FF42E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35596 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbcFXOX2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 10:23:28 -0400
Received: by mail-oi0-f49.google.com with SMTP id r2so117183753oih.2
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jun 2016 07:23:27 -0700 (PDT)
In-Reply-To: <BL2PR02MB21153E31C8C9206120947A3FF42E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Christian Balzer <chibi@gol.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, Blair Bethwaite <blair.bethwaite@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On the vm.vfs_cace_pressure =3D 1 :   We had this initially and I still
think it is the best choice for most configs.  However with our large
memory footprint, vfs_cache_pressure=3D1 increased the likelihood of
hitting an issue where our write response time would double; then a
drop of caches would return response time to normal.  I don't claim to
totally understand this and I only have speculation at the moment.
Again thanks for this suggestion, I do think it is best for boxes that
don't have very large memory.

@ Christian - reformatting to btrfs or ext4 is an option in my test
cluster.  I thought about that but needed to sort xfs first. (thats
what production will run right now) You all have helped me do that and
thank you again.  I will circle back and test btrfs under the same
conditions.  I suspect that it will behave similarly but it's only a
day and half's work or so to test.

Best Regards,
Wade


On Thu, Jun 23, 2016 at 8:09 PM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:
> Oops , typo , 128 GB :-)...
>
> -----Original Message-----
> From: Christian Balzer [mailto:chibi@gol.com]
> Sent: Thursday, June 23, 2016 5:08 PM
> To: ceph-users@lists.ceph.com
> Cc: Somnath Roy; Warren Wang - ISD; Wade Holler; Blair Bethwaite; Cep=
h Development
> Subject: Re: [ceph-users] Dramatic performance drop at certain number=
 of objects in pool
>
>
> Hello,
>
> On Thu, 23 Jun 2016 22:24:59 +0000 Somnath Roy wrote:
>
>> Or even vm.vfs_cache_pressure =3D 0 if you have sufficient memory to
>> *pin* inode/dentries in memory. We are using that for long now (with
>> 128 TB node memory) and it seems helping specially for the random
>> write workload and saving xattrs read in between.
>>
> 128TB node memory, really?
> Can I have some of those, too? ^o^
> And here I was thinking that Wade's 660GB machines were on the excess=
ive side.
>
> There's something to be said (and optimized) when your storage nodes =
have the same or more RAM as your compute nodes...
>
> As for Warren, well spotted.
> I personally use vm.vfs_cache_pressure =3D 1, this avoids the potenti=
al fireworks if your memory is really needed elsewhere, while keeping t=
hings in memory normally.
>
> Christian
>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behal=
f
>> Of Warren Wang - ISD Sent: Thursday, June 23, 2016 3:09 PM
>> To: Wade Holler; Blair Bethwaite
>> Cc: Ceph Development; ceph-users@lists.ceph.com
>> Subject: Re: [ceph-users] Dramatic performance drop at certain numbe=
r
>> of objects in pool
>>
>> vm.vfs_cache_pressure =3D 100
>>
>> Go the other direction on that. You=C2=B9ll want to keep it low to h=
elp
>> keep inode/dentry info in memory. We use 10, and haven=C2=B9t had a =
problem.
>>
>>
>> Warren Wang
>>
>>
>>
>>
>> On 6/22/16, 9:41 PM, "Wade Holler" <wade.holler@gmail.com> wrote:
>>
>> >Blairo,
>> >
>> >We'll speak in pre-replication numbers, replication for this pool i=
s 3.
>> >
>> >23.3 Million Objects / OSD
>> >pg_num 2048
>> >16 OSDs / Server
>> >3 Servers
>> >660 GB RAM Total, 179 GB Used (free -t) / Server vm.swappiness =3D =
1
>> >vm.vfs_cache_pressure =3D 100
>> >
>> >Workload is native librados with python.  ALL 4k objects.
>> >
>> >Best Regards,
>> >Wade
>> >
>> >
>> >On Wed, Jun 22, 2016 at 9:33 PM, Blair Bethwaite
>> ><blair.bethwaite@gmail.com> wrote:
>> >> Wade, good to know.
>> >>
>> >> For the record, what does this work out to roughly per OSD? And h=
ow
>> >> much RAM and how many PGs per OSD do you have?
>> >>
>> >> What's your workload? I wonder whether for certain workloads (e.g=
=2E
>> >> RBD) it's better to increase default object size somewhat before
>> >> pushing the split/merge up a lot...
>> >>
>> >> Cheers,
>> >>
>> >> On 23 June 2016 at 11:26, Wade Holler <wade.holler@gmail.com> wro=
te:
>> >>> Based on everyones suggestions; The first modification to 50 / 1=
6
>> >>> enabled our config to get to ~645Mill objects before the behavio=
r
>> >>> in question was observed (~330 was the previous ceiling).
>> >>> Subsequent modification to 50 / 24 has enabled us to get to 1.1
>> >>> Billion+
>> >>>
>> >>> Thank you all very much for your support and assistance.
>> >>>
>> >>> Best Regards,
>> >>> Wade
>> >>>
>> >>>
>> >>> On Mon, Jun 20, 2016 at 6:58 PM, Christian Balzer <chibi@gol.com=
>
>> >>>wrote:
>> >>>>
>> >>>> Hello,
>> >>>>
>> >>>> On Mon, 20 Jun 2016 20:47:32 +0000 Warren Wang - ISD wrote:
>> >>>>
>> >>>>> Sorry, late to the party here. I agree, up the merge and split
>> >>>>>thresholds. We're as high as 50/12. I chimed in on an RH ticket
>> >>>>>here.
>> >>>>> One of those things you just have to find out as an operator
>> >>>>>since it's  not well documented :(
>> >>>>>
>> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1219974
>> >>>>>
>> >>>>> We have over 200 million objects in this cluster, and it's sti=
ll
>> >>>>>doing  over 15000 write IOPS all day long with 302 spinning
>> >>>>>drives
>> >>>>>+ SATA SSD  journals. Having enough memory and dropping your
>> >>>>>vfs_cache_pressure  should also help.
>> >>>>>
>> >>>> Indeed.
>> >>>>
>> >>>> Since it was asked in that bug report and also my first
>> >>>>suspicion, it  would probably be good time to clarify that it
>> >>>>isn't the splits that cause  the performance degradation, but th=
e
>> >>>>resulting inflation of dir entries  and exhaustion of SLAB and
>> >>>>thus having to go to disk for things that  normally would be in =
memory.
>> >>>>
>> >>>> Looking at Blair's graph from yesterday pretty much makes that
>> >>>>clear, a  purely split caused degradation should have relented
>> >>>>much quicker.
>> >>>>
>> >>>>
>> >>>>> Keep in mind that if you change the values, it won't take effe=
ct
>> >>>>> immediately. It only merges them back if the directory is unde=
r
>> >>>>> the calculated threshold and a write occurs (maybe a read, I
>> >>>>> forget).
>> >>>>>
>> >>>> If it's a read a plain scrub might do the trick.
>> >>>>
>> >>>> Christian
>> >>>>> Warren
>> >>>>>
>> >>>>>
>> >>>>> From: ceph-users
>> >>>>>
>> >>>>><ceph-users-bounces@lists.ceph.com<mailto:ceph-users-bounces@li=
sts.
>> >>>>>cep
>> >>>>>h.com>>
>> >>>>> on behalf of Wade Holler
>> >>>>> <wade.holler@gmail.com<mailto:wade.holler@gmail.com>> Date:
>> >>>>>Monday, June  20, 2016 at 2:48 PM To: Blair Bethwaite
>> >>>>><blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com>>,
>> >>>>>Wido den  Hollander <wido@42on.com<mailto:wido@42on.com>> Cc:
>> >>>>>Ceph Development
>> >>>>><ceph-devel@vger.kernel.org<mailto:ceph-devel@vger.kernel.org>>=
,
>> >>>>> "ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>"
>> >>>>> <ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>>
>> >>>>>Subject:
>> >>>>> Re: [ceph-users] Dramatic performance drop at certain number o=
f
>> >>>>>objects  in pool
>> >>>>>
>> >>>>> Thanks everyone for your replies.  I sincerely appreciate it. =
We
>> >>>>> are testing with different pg_num and filestore_split_multiple
>> >>>>> settings. Early indications are .... well not great. Regardles=
s
>> >>>>> it is nice to understand the symptoms better so we try to desi=
gn
>> >>>>> around it.
>> >>>>>
>> >>>>> Best Regards,
>> >>>>> Wade
>> >>>>>
>> >>>>>
>> >>>>> On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite
>> >>>>><blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com>> w=
rote:
>> >>>>>On
>> >>>>> 20 June 2016 at 09:21, Blair Bethwaite
>> >>>>><blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com>> w=
rote:
>> >>>>> > slow request issues). If you watch your xfs stats you'll
>> >>>>> > likely get further confirmation. In my experience
>> >>>>> > xs_dir_lookups balloons
>> >>>>>(which
>> >>>>> > means directory lookups are missing cache and going to disk)=
=2E
>> >>>>>
>> >>>>> Murphy's a bitch. Today we upgraded a cluster to latest Hammer
>> >>>>> in preparation for Jewel/RHCS2. Turns out when we last hit thi=
s
>> >>>>> very problem we had only ephemerally set the new filestore
>> >>>>> merge/split values - oops. Here's what started happening when =
we
>> >>>>> upgraded and restarted a bunch of OSDs:
>> >>>>>
>> >>>>>https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-=
xs
>> >>>>>_d
>> >>>>>ir_
>> >>>>>lookup.png
>> >>>>>
>> >>>>> Seemed to cause lots of slow requests :-/. We corrected it abo=
ut
>> >>>>> 12:30, then still took a while to settle.
>> >>>>>
>> >>>>> --
>> >>>>> Cheers,
>> >>>>> ~Blairo
>> >>>>>
>> >>>>> This email and any files transmitted with it are confidential
>> >>>>>and intended solely for the individual or entity to whom they a=
re
>> >>>>>addressed.
>> >>>>> If you have received this email in error destroy it immediatel=
y.
>> >>>>>***  Walmart Confidential ***
>> >>>>
>> >>>>
>> >>>> --
>> >>>> Christian Balzer        Network/Systems Engineer
>> >>>> chibi@gol.com           Global OnLine Japan/Rakuten Communicati=
ons
>> >>>> http://www.gol.com/
>> >>
>> >>
>> >>
>> >> --
>> >> Cheers,
>> >> ~Blairo
>>
>> This email and any files transmitted with it are confidential and
>> intended solely for the individual or entity to whom they are addres=
sed.
>> If you have received this email in error destroy it immediately. ***
>> Walmart Confidential ***
>> _______________________________________________
>> ceph-users mailing list ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com PLEASE NOTE:
>> The information contained in this electronic mail message is intende=
d
>> only for the use of the designated recipient(s) named above. If the
>> reader of this message is not the intended recipient, you are hereby
>> notified that you have received this message in error and that any
>> review, dissemination, distribution, or copying of this message is
>> strictly prohibited. If you have received this communication in erro=
r,
>> please notify the sender by telephone or e-mail (as shown above)
>> immediately and destroy any and all copies of this message in your
>> possession (whether hard copies or electronically stored copies).
>> _______________________________________________ ceph-users mailing
>> list ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
> --
> Christian Balzer        Network/Systems Engineer
> chibi@gol.com   Global OnLine Japan/Rakuten Communications
> http://www.gol.com/
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
