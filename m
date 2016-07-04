From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Failing OSDs (suicide timeout) due to flaky clients
Date: Mon, 4 Jul 2016 17:54:36 +0200
Message-ID: <CABZ+qqk5G9S47-3chQ-81okkCEkUKhg=Dz_V4FHEnbwus7vBiA@mail.gmail.com>
References: <256042034.446.1467643268046@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35820 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGDPzU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2016 11:55:20 -0400
Received: by mail-lf0-f45.google.com with SMTP id l188so119589434lfe.2
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2016 08:55:19 -0700 (PDT)
Received: from mail-lf0-f46.google.com (mail-lf0-f46.google.com. [209.85.215.46])
        by smtp.gmail.com with ESMTPSA id 139sm4769983ljj.1.2016.07.04.08.55.16
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 08:55:16 -0700 (PDT)
Received: by mail-lf0-f46.google.com with SMTP id l188so119588898lfe.2
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2016 08:55:16 -0700 (PDT)
In-Reply-To: <256042034.446.1467643268046@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Wido,

On Mon, Jul 4, 2016 at 4:41 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> On a Ceph Hammer (0.94.5) cluster I've seen OSDs fail multiple times when one or more clients are responding flaky (full netfilter conntrack table).
>
> The cluster is a 250 OSD cluster with roughly 30 clients all running KVM/Qemu with librbd.
>
> What happens is that the cluster is doing roughly 10k IOps and then a client starts to experience packet loss. Due to this responses sent back to the client by the OSD might be lost and the OSD (TCP) will re-transmit these.
>
> The clients in this case run into a full conntrack table on the hypervisor which also causes Ceph traffic to be dropped.
>
> After a few minutes OSDs will start to commit suicide throughout the cluster:
>
>     -4> 2016-07-04 15:38:37.794230 7f8c9b63c700 10 monclient: renew_subs
>     -3> 2016-07-04 15:38:37.794235 7f8c9b63c700 10 monclient: _send_mon_message to mon.charlie at [2a00:f10:121:200::6789:3]:6789/0
>     -2> 2016-07-04 15:38:39.944116 7f8cb45a3700  1 heartbeat_map is_healthy 'OSD::osd_op_tp thread 0x7f8c95630700' had timed out after 15
>     -1> 2016-07-04 15:38:39.944146 7f8cb45a3700  1 heartbeat_map is_healthy 'OSD::osd_op_tp thread 0x7f8c95630700' had suicide timed out after 150
>      0> 2016-07-04 15:38:39.952054 7f8cb45a3700 -1 common/HeartbeatMap.cc: In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*, time_t)' thread 7f8cb45a3700 time 2016-07-04 15:38:39.944180
> common/HeartbeatMap.cc: 79: FAILED assert(0 == "hit suicide timeout")
>  ceph version 0.94.5 (9764da52395923e0b32908d83a9f7304401fee43)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0xbc60eb]
>  2: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, long)+0x2a9) [0xb02089]
>  3: (ceph::HeartbeatMap::is_healthy()+0xd6) [0xb02916]
>  4: (ceph::HeartbeatMap::check_touch_file()+0x17) [0xb02ff7]
>  5: (CephContextServiceThread::entry()+0x154) [0xbd61d4]
>  6: (()+0x8182) [0x7f8cb7a0d182]
>  7: (clone()+0x6d) [0x7f8cb5f5747d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

I don't understand why a client's full conntrack table would affect
heartbeats between OSDs.
Can you work backwards in the logs to see what 7f8c95630700 was doing?

>
> On other OSDs you might see messages like these come by:
>
>    -96> 2016-07-04 15:33:23.645713 7fa9b7243700  0 -- [XX:YY:AA:BB::30]:6803/7451 >> [XX:YY:AA:BB::29]:6800/1019342 pipe(0x2c4e4000 sd=22 :56587 s=1 pgs=835 cs=1 l=0 c=0x318f1de0).connect got RESETSESSION
>    -95> 2016-07-04 15:33:23.645836 7fa9db92d700  0 -- [XX:YY:AA:BB::30]:6803/7451 >> [XX:YY:AA:BB::39]:6822/2687 pipe(0x4914000 sd=20 :38712 s=1 pgs=20 cs=1 l=0 c=0x3e4e1080).connect got RESETSESSION
>    -94> 2016-07-04 15:33:24.563595 7faa09f29700 10 monclient: renew_subs
>    -93> 2016-07-04 15:33:24.563621 7faa09f29700 10 monclient: _send_mon_message to mon.beta at [2a00:f10:121:200::6789:2]:6789/0
>    -92> 2016-07-04 15:33:24.564221 7faa09f29700 10 monclient: renew_subs
>    -91> 2016-07-04 15:33:24.564226 7faa09f29700 10 monclient: _send_mon_message to mon.beta at [2a00:f10:121:200::6789:2]:6789/0
>    -90> 2016-07-04 15:33:24.567635 7faa09f29700 10 monclient: renew_subs
>    -89> 2016-07-04 15:33:24.567642 7faa09f29700 10 monclient: _send_mon_message to mon.beta at [2a00:f10:121:200::6789:2]:6789/0
>    -88> 2016-07-04 15:33:24.567667 7faa0cf2f700  0 log_channel(cluster) log [WRN] : map e382054 wrongly marked me down
>    -87> 2016-07-04 15:33:25.231536 7faa270cd700  1 heartbeat_map is_healthy 'OSD::osd_op_tp thread 0x7faa0271a700' had timed out after 15
>    -86> 2016-07-04 15:33:28.800283 7fa9e65d9700  0 -- [XX:YY:AA:BB::30]:6813/1007451 >> [XX:YY:AA:BB::20]:6821/2641 pipe(0x3706c000 sd=25 :48471 s=2 pgs=25097 cs=1 l=0 c=0x120c5fa0).fault, initiating reconnect
>    -85> 2016-07-04 15:33:28.800795 7fa9ec437700  0 -- [XX:YY:AA:BB::30]:6813/1007451 >> [XX:YY:AA:BB::39]:6813/4497 pipe(0x341bc000 sd=26 :53469 s=2 pgs=24916 cs=1 l=0 c=0xdadf8c0).fault, initiating reconnect
>    -84> 2016-07-04 15:33:28.801374 7fa9a4f81700  0 -- [XX:YY:AA:BB::30]:6813/1007451 >> [XX:YY:AA:BB::20]:6821/2641 pipe(0x3706c000 sd=25 :48473 s=1 pgs=25097 cs=2 l=0 c=0x120c5fa0).connect got RESETSESSION
>    -83> 2016-07-04 15:33:28.801832 7fa9aced3700  0 -- [XX:YY:AA:BB::30]:6813/1007451 >> [XX:YY:AA:BB::39]:6813/4497 pipe(0x341bc000 sd=26 :53471 s=1 pgs=24916 cs=2 l=0 c=0xdadf8c0).connect got RESETSESSION
>    -82> 2016-07-04 15:33:30.231626 7faa270cd700  1 heartbeat_map is_healthy 'OSD::osd_op_tp thread 0x7faa0271a700' had timed out after 15
>    -81> 2016-07-04 15:33:32.366023 7faa04f1f700 10 monclient: tick


Again, what did thread 7faa0271a700 last do before timing out?

(BTW, in the past we used

  ms tcp read timeout = 60

to work around strange el6 kernel networking bugs -- maybe it would help here.)

-- Dan

>
>
> Due to the flaky responses of the clients roughly 10 to 20 OSDs die or start to respond very, very slowly causing outage on RBD.
>
> As soon as the client is fixed it takes just a few minutes for the cluster to become healthy a proceed.
>
> To me it seems like there are some buffers inside the OSD which fill up and cause the OSD to respond slowly to other network traffic.
>
> Does that make any sense?
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
