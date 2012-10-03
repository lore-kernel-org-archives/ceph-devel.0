From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: mds cache size configuration option being ignored
Date: Wed, 3 Oct 2012 16:59:57 -0700
Message-ID: <CANLRBoxGiiW5MSGa8QJaKyJriWb-3UBvqJNQ4zVeNT95iyz54A@mail.gmail.com>
References: <CANLRBox7q8eJkJ8rKoyqrjdPLq7kjjqiMJx9MAdaSgCTtcmnog@mail.gmail.com>
	<CAPYLRzjhdsEqqfOV=pP2rZnegZRsjfaFr4LGFJooDkXqrA71Aw@mail.gmail.com>
	<CANLRBoxTasZcvo7s33ynoFmitk-ZZX10eYX-=k0db3bgcQOaAA@mail.gmail.com>
	<CAPYLRziwU3jHVAsv780bhQ0+Bz2oXNv0FipSPaTr_apz5WxyMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56137 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871Ab2JCX76 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 19:59:58 -0400
Received: by ieak13 with SMTP id k13so18612885iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 16:59:57 -0700 (PDT)
In-Reply-To: <CAPYLRziwU3jHVAsv780bhQ0+Bz2oXNv0FipSPaTr_apz5WxyMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 3, 2012 at 4:56 PM, Gregory Farnum <greg@inktank.com> wrote=
:
> On Wed, Oct 3, 2012 at 4:23 PM, Tren Blackburn <tren@eotnetworks.com>=
 wrote:
>> On Wed, Oct 3, 2012 at 4:15 PM, Gregory Farnum <greg@inktank.com> wr=
ote:
>>> On Wed, Oct 3, 2012 at 3:22 PM, Tren Blackburn <tren@eotnetworks.co=
m> wrote:
>>>> Hi List;
>>>>
>>>> I was advised to use the "mds cache size" option to limit the memo=
ry
>>>> that the mds process will take. I have it set to "32768". However =
it
>>>> the ceph-mds process is now at 50GB and still growing.
>>>>
>>>> fern ceph # ps wwaux | grep ceph-mds
>>>> root       895  4.3 26.6 53269304 52725820 ?   Ssl  Sep28 312:29
>>>> /usr/bin/ceph-mds -i fern --pid-file /var/run/ceph/mds.fern.pid -c
>>>> /etc/ceph/ceph.conf
>>>>
>>>> Have I specified the limit incorrectly? How far will it go?
>>>
>>> Oof. That looks correct; it sounds like we have a leak or some othe=
r
>>> kind of bug. I believe you're on Gentoo; did you build with tcmallo=
c?
>>> If so, can you run "ceph -w" in one window and then "ceph mds tell =
0
>>> heap stats" and send back the output?
>>> If you didn't build with tcmalloc, can you do so and try again? We
>>> have noticed fragmentation issues with the default memory allocator=
,
>>> which is why we switched (though I can't imagine it'd balloon that =
far
>>> =97 but tcmalloc will give us some better options to diagnose it). =
Sorry
>>> I didn't mention this before!
>>
>> Hey Greg! Good recall, I am on Gentoo, and I did build with tcmalloc=
=2E
>
> Search is a wonderful thing. ;)
>
>> Here is the information you requested:
>>
>> 2012-10-03 16:20:43.979673 mds.0 [INF] mds.ferntcmalloc heap
>> stats:------------------------------------------------
>> 2012-10-03 16:20:43.979676 mds.0 [INF] MALLOC:    53796808560 (51304=
=2E6
>> MiB) Bytes in use by application
>> 2012-10-03 16:20:43.979679 mds.0 [INF] MALLOC: +       753664 (    0=
=2E7
>> MiB) Bytes in page heap freelist
>> 2012-10-03 16:20:43.979681 mds.0 [INF] MALLOC: +     93299048 (   89=
=2E0
>> MiB) Bytes in central cache freelist
>> 2012-10-03 16:20:43.979683 mds.0 [INF] MALLOC: +      6110720 (    5=
=2E8
>> MiB) Bytes in transfer cache freelist
>> 2012-10-03 16:20:43.979685 mds.0 [INF] MALLOC: +     84547880 (   80=
=2E6
>> MiB) Bytes in thread cache freelists
>> 2012-10-03 16:20:43.979686 mds.0 [INF] MALLOC: +     84606976 (   80=
=2E7
>> MiB) Bytes in malloc metadata
>> 2012-10-03 16:20:43.979688 mds.0 [INF] MALLOC:   ------------
>> 2012-10-03 16:20:43.979690 mds.0 [INF] MALLOC: =3D  54066126848 (515=
61.5
>> MiB) Actual memory used (physical + swap)
>> 2012-10-03 16:20:43.979691 mds.0 [INF] MALLOC: +            0 (    0=
=2E0
>> MiB) Bytes released to OS (aka unmapped)
>> 2012-10-03 16:20:43.979693 mds.0 [INF] MALLOC:   ------------
>> 2012-10-03 16:20:43.979694 mds.0 [INF] MALLOC: =3D  54066126848 (515=
61.5
>> MiB) Virtual address space used
>> 2012-10-03 16:20:43.979700 mds.0 [INF] MALLOC:
>> 2012-10-03 16:20:43.979702 mds.0 [INF] MALLOC:         609757
>>     Spans in use
>> 2012-10-03 16:20:43.979703 mds.0 [INF] MALLOC:            395
>>     Thread heaps in use
>> 2012-10-03 16:20:43.979705 mds.0 [INF] MALLOC:           8192
>>     Tcmalloc page size
>> 2012-10-03 16:20:43.979710 mds.0 [INF]
>
> So tcmalloc thinks the MDS is actually using >50GB of RAM. ie, we hav=
e a leak.
>
> Sage suggests we check out the perfcounters (specifically, how many
> log segments are open). "ceph --admin-daemon </path/to/socket>
> perfcounters_dump" I believe the default path is
> /var/run/ceph/ceph-mds.a.asok.

Got it...

--- Start ---
fern ceph # ceph --admin-daemon /var/run/ceph/ceph-mds.fern.asok
perfcounters_dump
{"mds":{"req":0,"reply":48446606,"replyl":{"avgcount":48446606,"sum":28=
781.3},"fw":0,"dir_f":1238738,"dir_c":1709578,"dir_sp":0,"dir_ffc":0,"i=
max":32768,"i":9236006,"itop":421,"ibot":2,"iptail":9235583,"ipin":9236=
004,"iex":20572348,"icap":9235995,"cap":9235995,"dis":0,"t":60401624,"t=
hit":43843666,"tfw":0,"tdis":0,"tdirf":1235679,"trino":0,"tlock":0,"l":=
347,"q":0,"popanyd":0,"popnest":0,"sm":2,"ex":0,"iexp":0,"im":0,"iim":0=
},"mds_log":{"evadd":41768893,"evex":41734641,"evtrm":41734641,"ev":342=
52,"evexg":0,"evexd":1158,"segadd":44958,"segex":44928,"segtrm":44928,"=
seg":31,"segexg":0,"segexd":1,"expos":188437496802,"wrpos":188567160172=
,"rdpos":0,"jlat":0},"mds_mem":{"ino":9236008,"ino+":20540696,"ino-":11=
304688,"dir":1219715,"dir+":2806911,"dir-":1587196,"dn":9236006,"dn+":2=
9809444,"dn-":20573438,"cap":9235995,"cap+":20077556,"cap-":10841561,"r=
ss":52843824,"heap":10792,"malloc":-1925579,"buf":0},"mds_server":{"hcr=
eq":48446606,"hsreq":0,"hcsess":0,"dcreq":51199273,"dsreq":0},"objecter=
":{"op_active":0,"op_laggy":0,"op_send":6842412,"op_send_bytes":0,"op_r=
esend":216654,"op_ack":1238738,"op_commit":5387021,"op":6625759,"op_r":=
1238738,"op_w":5387021,"op_rmw":0,"op_pg":0,"osdop_stat":0,"osdop_creat=
e":0,"osdop_read":0,"osdop_write":3542566,"osdop_writefull":43897,"osdo=
p_append":0,"osdop_zero":0,"osdop_truncate":0,"osdop_delete":90980,"osd=
op_mapext":0,"osdop_sparse_read":0,"osdop_clonerange":0,"osdop_getxattr=
":0,"osdop_setxattr":3419156,"osdop_cmpxattr":0,"osdop_rmxattr":0,"osdo=
p_resetxattrs":0,"osdop_tmap_up":231883,"osdop_tmap_put":1477695,"osdop=
_tmap_get":1238738,"osdop_call":0,"osdop_watch":0,"osdop_notify":0,"osd=
op_src_cmpxattr":0,"osdop_pgls":0,"osdop_pgls_filter":0,"osdop_other":0=
,"linger_active":0,"linger_send":0,"linger_resend":0,"poolop_active":0,=
"poolop_send":0,"poolop_resend":0,"poolstat_active":0,"poolstat_send":0=
,"poolstat_resend":0,"statfs_active":0,"statfs_send":0,"statfs_resend":=
0,"map_epoch":69,"map_full":0,"map_inc":67,"osd_sessions":2418,"osd_ses=
sion_open":452224,"osd_session_close":452032,"osd_laggy":0},"throttle-m=
sgr_dispatch_throttler-mds":{"val":0,"max":104857600,"get":76466053,"ge=
t_sum":17902766691,"get_or_fail_fail":0,"get_or_fail_success":0,"take":=
0,"take_sum":0,"put":76466053,"put_sum":17902766691,"wait":{"avgcount":=
624620,"sum":1996.57}},"throttle-objecter_bytes":{"val":0,"max":1048576=
00,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success":0,"ta=
ke":6625759,"take_sum":193714902197,"put":5296041,"put_sum":19371490219=
7,"wait":{"avgcount":0,"sum":0}},"throttle-objecter_ops":{"val":0,"max"=
:1024,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success":0,=
"take":6625759,"take_sum":6625759,"put":6625759,"put_sum":6625759,"wait=
":{"avgcount":0,"sum":0}}}
--- End ---

>
> If this doesn't provide us a clue, I'm afraid we're going to have to
> start keeping track of heap usage with tcmalloc or run the daemon
> through massif...

Hmm, well let me know if there's anything else I can provide. And
thanks again for your help.

t.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
