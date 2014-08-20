From: Guang Yang <yguang11@outlook.com>
Subject: Re: OSD suicide after being down/in for one day as it needs to search large amount of objects
Date: Wed, 20 Aug 2014 19:42:31 +0800
Message-ID: <BLU436-SMTP149AEBB380BB925D15D777ADFD20@phx.gbl>
References: <BLU436-SMTP1407B6BAC746323A36B7947DFD50@phx.gbl> <CAPYLRzh5eNVqPVWGgDKSOsQ6MaDVgxnki=1dzf9Nnw5UOO6HXw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s13.hotmail.com ([65.55.111.152]:62209 "EHLO
	BLU004-OMC4S13.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451AbaHTLmq convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Aug 2014 07:42:46 -0400
In-Reply-To: <CAPYLRzh5eNVqPVWGgDKSOsQ6MaDVgxnki=1dzf9Nnw5UOO6HXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>, david.z1003@yahoo.com

Thanks Greg.
On Aug 20, 2014, at 6:09 AM, Gregory Farnum <greg@inktank.com> wrote:

> On Mon, Aug 18, 2014 at 11:30 PM, Guang Yang <yguang11@outlook.com> w=
rote:
>> Hi ceph-devel,
>> David (cc=92ed) reported a bug (http://tracker.ceph.com/issues/9128)=
 which we came across in our test cluster during our failure testing, b=
asically the way to reproduce it was to leave one OSD daemon down and i=
n for a day, at the same time, keep giving write traffic. When the OSD =
daemon was started again, it hit suicide timeout and kill itself.
>>=20
>> After some analysis (details in the bug), David found that the op th=
read was busy searching for missing objects and once the volume to sear=
ch increase, the thread is expected to work that long time, please refe=
r to the bug for detailed logs.
>=20
> Can you talk a little more about what's going on here? At a quick
> naive glance, I'm not seeing why leaving an OSD down and in should
> require work based on the amount of write traffic. Perhaps if the res=
t
> of the cluster was changing mappings=85?
We increased the down to out time interval from 5 minutes to 2 days to =
avoid migrating data back and forth which could increase latency, so th=
at we target to mark OSD out manually. To achieve such, we are testing =
against some boundary cases to let the OSD down and in for like 1 day, =
however, when we try to bring it up again, it always failed due to hit =
the suicide timeout.
>=20
>>=20
>> One simple fix is to let the op thread reset the suicide timeout per=
iodically when it is doing long-time work, other fix might be to cut th=
e work into smaller pieces?
>=20
> We do both of those things throughout the OSD (although I think the
> first is simpler and more common); search for the accesses to
> cct->get_heartbeat_map()->reset_timeout.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
