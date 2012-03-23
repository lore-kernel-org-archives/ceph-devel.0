From: ruslan usifov <ruslan.usifov@gmail.com>
Subject: Re: periodically delays when one of mons dies
Date: Fri, 23 Mar 2012 12:57:47 +0400
Message-ID: <CAHULbCk90QZ7J0gc+_8V7LW9i5Amz2jxSo6QPJKx3Pp90Q4SBg@mail.gmail.com>
References: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
	<CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
	<63F3EB16E0CC4D6E9AC1F738A38838F0@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54809 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab2CWI5s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 04:57:48 -0400
Received: by yenl12 with SMTP id l12so2529693yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Mar 2012 01:57:47 -0700 (PDT)
In-Reply-To: <63F3EB16E0CC4D6E9AC1F738A38838F0@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

2012/3/22 Greg Farnum <gregory.farnum@dreamhost.com>:
> On Wednesday, March 21, 2012 at 8:30 AM, ruslan usifov wrote:
>> Hello
>>
>> I'm new to ceph, and perhaps misunderstand some things.
>>
>> I have test configuration with 3 wmvare machines (i test RBD). My se=
tup
>> consist of:
>>
>> 3: mons
>> 3: osd
>>
>>
>> When i kill one mon (simulate fail), time to time (periodicaly) i go=
t little
>> delays when work with RBD device, perhaps this happens when client t=
ry
>> failed mon
>
> That's probably the case -- the tools generally pick a random monitor=
 from the list and time out after 15 seconds if it's not responding. If=
 you know a monitor is down you can specify one of the others to connec=
t to with the -m option.
>
>> , is it possible switch off this failed mon until it fully
>> restore.
>
> You could take it out of the daemon's config file, but there's no way=
 for new daemons to avoid trying to talk to down monitors which are in =
their config (unless you explicitly specify the mon to connect to, as I=
 said above) -- the monitor is the first part of the system they talk t=
o, so there's not a way for Ceph itself to propagate information about =
down mons.
>
>> perhaps pacemaker will help in this case + failover ip + somthing
>> like proxy which known about mon configuration (i try haproxy but wi=
thout
>> success: 1 first of all haproxy doesn't know about live or fail mons=
 sof
>> delays will happens also ceph doesn't allow this scheme - ie ceph cl=
ient
>> check ip address on which it connect and what send to hip mon, and i=
n schem
>> with proxy this values doesn't coincide)
>
> Not quite sure what you're saying here...
> -Greg
>

Sorry for my bad English.

I mean that, if throw pacemaker we organize fault tolerant monitor
(monitor that will work all time - even in fail case), we prevent
delays. In my prevoiuse post i describe how i try to solve this
problem (but with out success), now i try to describe more  =D3learly m=
y
view of this:

Lets imagine that we have some thing that every time know about mon
cluster configuration, and behave like mon (bet name is mon proxy) ,
and this thing can simply migrate from node to node in fail case, and
in our cluster all daemons (osd, mds) include client utils, will
connect to this fault tolerant thing (so we doens't have delays).

To mplement this solution i try to use haproxy
(http://haproxy.1wt.eu/) but ceph check ip adrees of mon to which it
try to connect (in src/msg/SimpleMessenger.cc - line 1125):


  ldout(msgr->cct,20) << "connect read peer addr " << paddr << " on
socket " << sd << dendl;
  if (peer_addr !=3D paddr) {
    if (paddr.is_blank_ip() &&
	peer_addr.get_port() =3D=3D paddr.get_port() &&
	peer_addr.get_nonce() =3D=3D paddr.get_nonce()) {
      ldout(msgr->cct,0) << "connect claims to be "
	      << paddr << " not " << peer_addr << " - presumably this is the
same node!" << dendl;
    } else {
      ldout(msgr->cct,0) << "connect claims to be "
	      << paddr << " not " << peer_addr << " - wrong node!" << dendl;
      goto fail;
    }
  }


And i got error:-(((  Also haproxy prevents delays only partially:-(
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
