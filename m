From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Single MDS cephx key
Date: Tue, 3 Oct 2017 00:14:43 +0800
Message-ID: <CAEYCsVL3B82jQSwMXa3zu_QTT+hc46uVi0DBCf5oPJ1f0Nq-rg@mail.gmail.com>
References: <D5F02A0B.9B73A%travis.nielsen@quantum.com> <CALe9h7cNg-6fq8pQSOzW+SYn0StV0R-NQtt3s5QjxoAjHxY9fg@mail.gmail.com>
 <D5F11CB7.9B833%travis.nielsen@quantum.com> <CALe9h7dMy45R=m=2gPtoDAyibM3e4COfnhyx9FbuFZcrCuQwEg@mail.gmail.com>
 <D5F126E8.9B868%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:48296 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdJBQOp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 12:14:45 -0400
Received: by mail-it0-f53.google.com with SMTP id m123so8051106ita.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 09:14:44 -0700 (PDT)
In-Reply-To: <D5F126E8.9B868%travis.nielsen@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Nielsen <Travis.Nielsen@quantum.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

FWIW, below is our mds log when an MDS turn from standby-replay to
active, it take really long time especially on rejoin. The FS do go
with 100+ clients and a few million of files.

So it seems that MDS restart/replace is not that **light weight** as
we are thinking about.



2017-09-29 08:07:27.738118 7fe34d085700  1 mds.0.0 replay_done (as standby)
2017-09-29 08:07:28.835714 7fe34d085700  1 mds.0.0 replay_done (as standby)
2017-09-29 08:07:29.932846 7fe34d085700  1 mds.0.0 replay_done (as standby)
2017-09-29 08:07:31.034661 7fe353091700  1 mds.0.5419 handle_mds_map i
am now mds.0.5419
2017-09-29 08:07:31.034663 7fe353091700  1 mds.0.5419 handle_mds_map
state change up:standby-replay --> up:replay
2017-09-29 08:07:31.063181 7fe34d085700  1 mds.0.5419 replay_done (as standby)
2017-09-29 08:07:31.063201 7fe34d085700  1 mds.0.5419
standby_replay_restart (final takeover pass)
2017-09-29 08:07:31.168992 7fe34d085700  1 mds.0.5419 replay_done
2017-09-29 08:07:31.169005 7fe34d085700  1 mds.0.5419 making mds
journal writeable
2017-09-29 08:07:32.046255 7fe353091700  1 mds.0.5419 handle_mds_map i
am now mds.0.5419
2017-09-29 08:07:32.046257 7fe353091700  1 mds.0.5419 handle_mds_map
state change up:replay --> up:resolve
2017-09-29 08:07:32.046265 7fe353091700  1 mds.0.5419 resolve_start
2017-09-29 08:07:32.046267 7fe353091700  1 mds.0.5419 reopen_log
2017-09-29 08:07:32.046274 7fe353091700  1 mds.0.5419  recovery set is 1
2017-09-29 08:08:14.856587 7fe353091700  1 mds.0.cache
handle_mds_failure mds.1 : recovery peers are 1
2017-09-29 08:08:15.863834 7fe353091700  1 mds.0.5419  recovery set is 1
2017-09-29 08:08:15.868900 7fe356034700  0 --
10.148.245.147:6800/3329170275 >> 10.148.245.145:6804/3466203682
conn(0x55b64a7c6000 :6800 s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH
pgs=0 cs=0 l=0).handle_connect_msg accept connect_seq 0 vs existing
csq=0 existing_state=STATE_CONNECTING
2017-09-29 08:08:19.957946 7fe353091700  1 mds.0.5419 resolve_done
2017-09-29 08:08:24.950118 7fe353091700  1 mds.0.5419 handle_mds_map i
am now mds.0.5419
2017-09-29 08:08:24.950171 7fe353091700  1 mds.0.5419 handle_mds_map
state change up:resolve --> up:reconnect
2017-09-29 08:08:24.950194 7fe353091700  1 mds.0.5419 reconnect_start
2017-09-29 08:08:24.950634 7fe353091700  1 mds.0.server
reconnect_clients -- 186 sessions
2017-09-29 08:08:24.950839 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34337 10.148.245.251:0/2769043642 after
0.000084
2017-09-29 08:08:24.960074 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34330 10.148.185.72:0/2433467420 after
0.009367
2017-09-29 08:08:24.964139 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34322 10.148.190.129:0/647912525 after
0.013405
2017-09-29 08:08:24.964331 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.104245 10.148.184.144:0/2533535048 after
0.013667
2017-09-29 08:08:24.964843 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34319 10.148.190.128:0/99750648 after
0.014185
2017-09-29 08:08:24.966976 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.104212 10.148.184.140:0/1486286861 after
0.016276
2017-09-29 08:08:24.967093 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.104225 10.148.184.131:0/3388986983 after
0.016435
2017-09-29 08:08:24.967263 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.104255 10.148.184.130:0/4145162106 after
0.016546
2017-09-29 08:08:24.967344 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34313 10.148.190.155:0/2880915725 after
0.016690

2017-09-29 08:08:42.996768 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34328 10.148.178.59:0/3803632372 after
18.046088
2017-09-29 08:08:43.886804 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34315 10.148.190.180:0/3130069617 after
18.936122
2017-09-29 08:08:44.696920 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34280 10.148.190.176:0/3500883319 after
19.746237
2017-09-29 08:08:45.531987 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34225 10.148.178.35:0/1295837455 after
20.581320
2017-09-29 08:08:46.524033 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34160 10.148.178.28:0/3696130157 after
21.573369
2017-09-29 08:08:47.285174 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34324 10.148.190.167:0/2637778599 after
22.334416
2017-09-29 08:08:48.173818 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34140 10.148.178.37:0/474083565 after
23.223125
2017-09-29 08:08:48.976772 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34128 10.148.178.40:0/3470525153 after
24.026070
2017-09-29 08:08:49.680177 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34283 10.148.190.172:0/561253376 after
24.729396
2017-09-29 08:08:50.457263 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34231 10.148.178.21:0/686475218 after
25.506604
2017-09-29 08:08:51.216427 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34204 10.148.178.64:0/2775534546 after
26.265759
2017-09-29 08:08:52.063327 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34207 10.148.178.66:0/2705035982 after
27.112667
2017-09-29 08:08:52.726760 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34178 10.148.178.26:0/168300491 after
27.775987
2017-09-29 08:08:53.346579 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34169 10.148.178.31:0/561092381 after
28.395917
2017-09-29 08:08:53.998588 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34237 10.148.178.33:0/718178560 after
29.047928
2017-09-29 08:08:54.810011 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34219 10.148.178.41:0/3334906872 after
29.859354
2017-09-29 08:08:55.692896 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34187 10.148.178.63:0/2527423535 after
30.742233
2017-09-29 08:08:56.663520 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34287 10.148.190.175:0/1683041168 after
31.712852
2017-09-29 08:08:57.501470 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34272 10.148.190.178:0/2415576439 after
32.550770
2017-09-29 08:08:58.324454 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34175 10.148.178.43:0/2792043288 after
33.373769
2017-09-29 08:08:59.197349 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34143 10.148.178.49:0/119222329 after
34.246687
2017-09-29 08:08:59.981611 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34149 10.148.178.20:0/2783244186 after
35.030950
2017-09-29 08:09:00.884353 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34216 10.148.178.32:0/2085010403 after
35.933695
2017-09-29 08:09:01.687472 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34303 10.148.190.183:0/2441938068 after
36.736810
2017-09-29 08:09:03.390089 7fe353091700  0 log_channel(cluster) log
[DBG] : reconnect by client.34112 10.148.245.113:0/556076324 after
38.439312
2017-09-29 08:09:03.390209 7fe353091700  1 mds.0.5419 reconnect_done
2017-09-29 08:09:03.451448 7fe353091700  1 mds.0.5419 handle_mds_map i
am now mds.0.5419
2017-09-29 08:09:03.451468 7fe353091700  1 mds.0.5419 handle_mds_map
state change up:reconnect --> up:rejoin
2017-09-29 08:09:03.451487 7fe353091700  1 mds.0.5419 rejoin_start
2017-09-29 08:09:08.306597 7fe353091700  1 mds.0.5419 rejoin_joint_start
2017-09-29 08:12:46.172231 7fe353091700  1 mds.0.5419 rejoin_done
2017-09-29 08:12:49.354507 7fe353091700  1 mds.0.5419 handle_mds_map i
am now mds.0.5419
2017-09-29 08:12:49.354518 7fe353091700  1 mds.0.5419 handle_mds_map
state change up:rejoin --> up:clientreplay
2017-09-29 08:12:49.354529 7fe353091700  1 mds.0.5419 recovery_done --
successful recovery!
2017-09-29 08:12:49.354944 7fe353091700  1 mds.0.5419 clientreplay_start
2017-09-29 08:12:50.325607 7fe34e888700  1 mds.0.5419 clientreplay_done
2017-09-29 08:12:50.983391 7fe353091700  1 mds.0.5419 handle_mds_map i
am now mds.0.5419
2017-09-29 08:12:50.983393 7fe353091700  1 mds.0.5419 handle_mds_map
state change up:clientreplay --> up:active
2017-09-29 08:12:50.983410 7fe353091700  1 mds.0.5419 active_start

2017-09-28 1:01 GMT+08:00 Travis Nielsen <Travis.Nielsen@quantum.com>:
> Thanks for the clarification, and Rook does use Kubernetes facilities to
> handle the log collection so it sounds like we're good to go.
>
>
>
> On 9/27/17, 9:45 AM, "John Spray" <jspray@redhat.com> wrote:
>
>>On Wed, Sep 27, 2017 at 5:36 PM, Travis Nielsen
>><Travis.Nielsen@quantum.com> wrote:
>>> To expand on the scenario, I'm working in a Kubernetes environment where
>>> the MDS instances are somewhat ephemeral. If an instance (pod) dies or
>>>the
>>> machine is restarted, Kubernetes will start a new one in its place. To
>>> handle the failed pod scenario, I'd appreciate if you could help me
>>> understand MDS better.
>>>
>>> 1) MDS instances are stateless, correct? If so, I'm assuming when an MDS
>>> instance dies, a new MDS instance (with a new ID) can be brought up and
>>> assigned its rank without any side effects other than disruption during
>>> the failover. Or is there a reason to treat them more like mons that
>>>need
>>> to survive reboots and maintain state?
>>
>>Yep, completely stateless.  Don't forget logs though -- for ephemeral
>>instances, it would be a good idea to have them sending their logs
>>somewhere central, so that we don't lose all the history whenever a
>>container restarts (you may very well have already covered this in
>>general in the context of Rook).
>>
>>> 2) Will there be any side effects from MDS instances being somewhat
>>> ephemeral? For example, if a new instance came up every hour or every
>>>day,
>>> what challenges would I run into besides cleaning up the old cephx keys?
>>
>>While switching daemons around is an online operation, it is not
>>without some impact to client IOs, and the freshly started MDS daemon
>>will generally have a less well populated cache than the one it is
>>replacing.
>>
>>John
>>
>>>
>>> Thanks!
>>> Travis
>>>
>>>
>>>
>>>
>>> On 9/27/17, 3:01 AM, "John Spray" <jspray@redhat.com> wrote:
>>>
>>>>On Wed, Sep 27, 2017 at 12:09 AM, Travis Nielsen
>>>><Travis.Nielsen@quantum.com> wrote:
>>>>> Is it possible to use the same cephx key for all instances of MDS or
>>>>>do
>>>>> they each require their own? Mons require the same keyring so I tried
>>>>> following the same pattern by creating a keyring with "mds.", but the
>>>>>MDS
>>>>> is complaining about not being authorized when it tries to start. Am I
>>>>> missing something or is this not possible for MDS keys? If I create a
>>>>> unique key for each MDS instance it works fine, but it would simplify
>>>>>my
>>>>> scenario if I could use the same key. I'm running on Luminous.
>>>>
>>>>I've never heard of anyone trying to do this.
>>>>
>>>>It's probably not a great idea, because if all MDS daemons are using
>>>>the same key then you lose the ability to simply remove an MDS's key
>>>>to ensure that it can't talk to the system any more.  This is useful
>>>>when tearing something down, because it means you're not taking it on
>>>>faith that the daemon is really physically stopped.
>>>>
>>>>John
>>>>
>>>>> The key was generated with this:
>>>>> ceph auth get-or-create-key mds. osd allow * mds allow mon allow
>>>>>profile
>>>>> mds
>>>>>
>>>>>
>>>>>
>>>>> The keyring contents are:
>>>>> [mds.]
>>>>> key = AQD62spZw3zRGhAAkHHVokP3BDf8PEy4+vXGMg==
>>>>>
>>>>>
>>>>> I run the following with that keyring:
>>>>> ceph-mds --foreground --name=mds.mymds -i mymds
>>>>>
>>>>> And I see the error:
>>>>> 2017-09-26 22:55:55.973047 7fb004459200 -1 mds.mds81c2n ERROR: failed
>>>>>to
>>>>> authenticate: (22) Invalid argument
>>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Travis
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at
>>>>>https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.ke
>>>>>rn
>>>>>el.org%2Fmajordomo-info.html&data=02%7C01%7CTravis.Nielsen%40quantum.co
>>>>>m%
>>>>>7C00d1db42478d48fa8c6508d5058ec254%7C322a135f14fb4d72aede122272134ae0%7
>>>>>C1
>>>>>%7C0%7C636421033061815149&sdata=3Vu79xeZbnb1jwhGE85PACq6qByVE6vUlPjp8pj
>>>>>rv
>>>>>hA%3D&reserved=0
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
