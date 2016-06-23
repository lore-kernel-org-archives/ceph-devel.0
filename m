From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
 objects in pool
Date: Thu, 23 Jun 2016 22:24:59 +0000
Message-ID: <BL2PR02MB2115BD5C173011A0CB92F964F42D0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
	<CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
	<D38DCB57.131AE%warren.wang@walmart.com>
	<20160621075856.3ad471d1@batzmaru.gol.ad.jp>
	<CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
	<CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
	<CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
	<D391D1A4.145D6%warren.wang@walmart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <D391D1A4.145D6%warren.wang-dFwxUrggiyBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Warren Wang - ISD <Warren.Wang-dFwxUrggiyBBDgjK7y7TUQ@public.gmane.org>, Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Or even vm.vfs_cache_pressure =3D 0 if you have sufficient memory to *pin* =
inode/dentries in memory.
We are using that for long now (with 128 TB node memory) and it seems helpi=
ng specially for the random write workload and saving xattrs read in betwee=
n.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Wa=
rren Wang - ISD
Sent: Thursday, June 23, 2016 3:09 PM
To: Wade Holler; Blair Bethwaite
Cc: Ceph Development; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] Dramatic performance drop at certain number of ob=
jects in pool

vm.vfs_cache_pressure =3D 100

Go the other direction on that. You=B9ll want to keep it low to help keep i=
node/dentry info in memory. We use 10, and haven=B9t had a problem.


Warren Wang




On 6/22/16, 9:41 PM, "Wade Holler" <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>Blairo,
>
>We'll speak in pre-replication numbers, replication for this pool is 3.
>
>23.3 Million Objects / OSD
>pg_num 2048
>16 OSDs / Server
>3 Servers
>660 GB RAM Total, 179 GB Used (free -t) / Server vm.swappiness =3D 1
>vm.vfs_cache_pressure =3D 100
>
>Workload is native librados with python.  ALL 4k objects.
>
>Best Regards,
>Wade
>
>
>On Wed, Jun 22, 2016 at 9:33 PM, Blair Bethwaite
><blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Wade, good to know.
>>
>> For the record, what does this work out to roughly per OSD? And how
>> much RAM and how many PGs per OSD do you have?
>>
>> What's your workload? I wonder whether for certain workloads (e.g.
>> RBD) it's better to increase default object size somewhat before
>> pushing the split/merge up a lot...
>>
>> Cheers,
>>
>> On 23 June 2016 at 11:26, Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Based on everyones suggestions; The first modification to 50 / 16
>>> enabled our config to get to ~645Mill objects before the behavior in
>>> question was observed (~330 was the previous ceiling).  Subsequent
>>> modification to 50 / 24 has enabled us to get to 1.1 Billion+
>>>
>>> Thank you all very much for your support and assistance.
>>>
>>> Best Regards,
>>> Wade
>>>
>>>
>>> On Mon, Jun 20, 2016 at 6:58 PM, Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
>>>wrote:
>>>>
>>>> Hello,
>>>>
>>>> On Mon, 20 Jun 2016 20:47:32 +0000 Warren Wang - ISD wrote:
>>>>
>>>>> Sorry, late to the party here. I agree, up the merge and split
>>>>>thresholds. We're as high as 50/12. I chimed in on an RH ticket here.
>>>>> One of those things you just have to find out as an operator since
>>>>>it's  not well documented :(
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1219974
>>>>>
>>>>> We have over 200 million objects in this cluster, and it's still
>>>>>doing  over 15000 write IOPS all day long with 302 spinning drives
>>>>>+ SATA SSD  journals. Having enough memory and dropping your
>>>>>vfs_cache_pressure  should also help.
>>>>>
>>>> Indeed.
>>>>
>>>> Since it was asked in that bug report and also my first suspicion,
>>>>it  would probably be good time to clarify that it isn't the splits
>>>>that cause  the performance degradation, but the resulting inflation
>>>>of dir entries  and exhaustion of SLAB and thus having to go to disk
>>>>for things that  normally would be in memory.
>>>>
>>>> Looking at Blair's graph from yesterday pretty much makes that
>>>>clear, a  purely split caused degradation should have relented much
>>>>quicker.
>>>>
>>>>
>>>>> Keep in mind that if you change the values, it won't take effect
>>>>> immediately. It only merges them back if the directory is under
>>>>> the calculated threshold and a write occurs (maybe a read, I forget).
>>>>>
>>>> If it's a read a plain scrub might do the trick.
>>>>
>>>> Christian
>>>>> Warren
>>>>>
>>>>>
>>>>> From: ceph-users
>>>>>
>>>>><ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-bounces@lists.
>>>>>cep
>>>>>h.com>>
>>>>> on behalf of Wade Holler
>>>>> <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> Date:
>>>>>Monday, June  20, 2016 at 2:48 PM To: Blair Bethwaite
>>>>><blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>, Wido
>>>>>den  Hollander <wido-fspyXLx8qC4@public.gmane.org<mailto:wido-fspyXLx8qC4@public.gmane.org>> Cc: Ceph
>>>>>Development
>>>>><ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>>,
>>>>> "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>"
>>>>> <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>>
>>>>>Subject:
>>>>> Re: [ceph-users] Dramatic performance drop at certain number of
>>>>>objects  in pool
>>>>>
>>>>> Thanks everyone for your replies.  I sincerely appreciate it. We
>>>>> are testing with different pg_num and filestore_split_multiple settin=
gs.
>>>>> Early indications are .... well not great. Regardless it is nice
>>>>> to understand the symptoms better so we try to design around it.
>>>>>
>>>>> Best Regards,
>>>>> Wade
>>>>>
>>>>>
>>>>> On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite
>>>>><blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>>>On
>>>>> 20 June 2016 at 09:21, Blair Bethwaite
>>>>><blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>>> > slow request issues). If you watch your xfs stats you'll likely
>>>>> > get further confirmation. In my experience xs_dir_lookups
>>>>> > balloons
>>>>>(which
>>>>> > means directory lookups are missing cache and going to disk).
>>>>>
>>>>> Murphy's a bitch. Today we upgraded a cluster to latest Hammer in
>>>>> preparation for Jewel/RHCS2. Turns out when we last hit this very
>>>>> problem we had only ephemerally set the new filestore merge/split
>>>>> values - oops. Here's what started happening when we upgraded and
>>>>> restarted a bunch of OSDs:
>>>>>
>>>>>https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-xs_d
>>>>>ir_
>>>>>lookup.png
>>>>>
>>>>> Seemed to cause lots of slow requests :-/. We corrected it about
>>>>> 12:30, then still took a while to settle.
>>>>>
>>>>> --
>>>>> Cheers,
>>>>> ~Blairo
>>>>>
>>>>> This email and any files transmitted with it are confidential and
>>>>>intended solely for the individual or entity to whom they are
>>>>>addressed.
>>>>> If you have received this email in error destroy it immediately.
>>>>>***  Walmart Confidential ***
>>>>
>>>>
>>>> --
>>>> Christian Balzer        Network/Systems Engineer
>>>> chibi-FW+hd8ioUD0@public.gmane.org           Global OnLine Japan/Rakuten Communications
>>>> http://www.gol.com/
>>
>>
>>
>> --
>> Cheers,
>> ~Blairo

This email and any files transmitted with it are confidential and intended =
solely for the individual or entity to whom they are addressed. If you have=
 received this email in error destroy it immediately. *** Walmart Confident=
ial *** _______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
