From: Karoly Horvath <rhswdev@gmail.com>
Subject: Re: how can I achieve HA with ceph?
Date: Tue, 20 Dec 2011 18:07:41 +0000
Message-ID: <CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:32863 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab1LTSHm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 13:07:42 -0500
Received: by werm1 with SMTP id m1so2166167wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 10:07:41 -0800 (PST)
In-Reply-To: <CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
all test were made with kill -9, killing the active mds (and sometimes
other processes).I waited a couple of minutes between each test to
make sure that the cluster reached a stable state.(btw: how can I
check this programmatically?)
# =A0KILLED =A0 =A0 =A0 =A0 =A0 result1. mds @ beta =A0 =A0 =A0 OK2. md=
s @ alpha
OK3. mds+osd @ beta =A0 FAILED=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
witch ok
{0=3Dalpha=3Dup:active}, but FS not readable=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 FS
permanently freezed=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rebooted the=
 whole cluster4.
mds+mon @ alpha =A0OK (32 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r=
ebooted the whole
cluster5. mds+osd @ beta =A0 OK (25 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 rebooted the
whole cluster6. mds+osd @ beta =A0 OK (24 sec)7. mds+osd @ alpha =A0OK =
(30
sec)8. mds+mon+osd @ beta =A0OK (27 sec)9. power unplug @ alpha FAILED
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stuck in {0=3Dbeta=3Dup:replay} for a =
long time
 =A0 =A0 =A0 =A0 finally it's switching to {0=3Dalpha=3Dup:active}, but=
 FS not
readable=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FS permanently freezed,=
 even when bringing
up alpha...
I uploaded test results here:
http://www.4shared.com/file/5nXMw_sM/cephlogs_mds_test.html?
If you need any other configuration options changed, let me know..logs
were created with:

mkdir -p $LOGDIRtail -f /var/log/ceph/mds.*.log >$LOGDIR/mds.log
&p1=3D$!tail -f /var/log/ceph/mon.*.log >$LOGDIR/mon.log &p2=3D$!tail -=
f
/var/log/ceph/osd.*.log >$LOGDIR/osd.log &p3=3D$!ceph -w
>$LOGDIR/ceph.log &p4=3D$!
read linekill $p1 $p2 $p3 $p4
# anonimize ip addressesfor f in $LOGDIR/*.log; do=A0 =A0 sed -r -i
's/[0-9]+\.[0-9]+\.[0-9]+\.([0-9]+)/xxx.xxx.xxx.\1/g' $fdone
--=A0Karoly Horvathrhswdev@gmail.com

On Mon, Dec 19, 2011 at 10:50 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Sun, Dec 18, 2011 at 11:26 AM, Karoly Horvath <rhswdev@gmail.com> =
wrote:
>> Hi Guys,
>>
>> two questions:
>>
>> first one is short:
>> The documentation states for all the daemons that they have to be an
>> odd number to work correctly.
>> But what happens if one of the nodes is down? Then, by definition
>> there will be an even number of daemons.
>> Can the system tolerate this failure? If not, do I have to automate
>> the process of quickly bringing up a new node to achieve HA?
>>
>> the second one:
>> I have a simple configuration:
>>
>> ceph version 0.39 (commit:321ecdaba2ceeddb0789d8f4b7180a8ea5785d83)
>> xxx.xxx.xxx.31 alpha (mds, mon, osd)
>> xxx.xxx.xxx.33 beta =A0(mds, mon, osd)
>> xxx.xxx.xxx.35 gamma ( =A0 =A0 mon, osd)
>> ceph FS is mounted with listing the two mds-es.
>> I set 'data' and 'metadata' to 2, then tested with 3.
>>
>> I've read the documentation and it suggests this should be enough to
>> achieve High Availability.
>> The data is replicated on all the osd-s (3), there is at least 1 mds
>> up all the time...yet:
>>
>> Each time I remove the power plug from the primary mds node's host,
>> the system goes down and I cannot do a simple `ls`.
>> I can replicate this problem and send you any logfiles or ceph -w
>> outputs you need. Let me know what you need.
>> Here is an example session: http://pastebin.com/R4MgdhUy
>>
>> I once saw the standby mds to wake up and then the FS worked but tha=
t
>> was after 20 minutes, which is way too long for a HA scenario.
>>
>> There is hardly any data on the FS at the moment (400MB, lol..), and
>> hardly any writes...
>>
>> I'm willing to sacrifice (a lot of) performance to achieve high avai=
lability.
>> Let me know if there are configuration settings to achieve this.
> TV's right. Specifically regarding the MDS:
> As TV said, the MDS should time out and get replaced within 30 second=
s
> (this is controlled by the "mds beacon grace" setting). It is a
> failover procedure, not shared masters or something, but from my
> experience it takes on the order of 10 seconds to complete once
> failure is detected. 20 minutes is completely wrong. If we're not
> already talking elsewhere, then I'd like it if you could enable MDS
> logging and reproduce this and post the logs somewhere so I can check
> out what's going on.
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
