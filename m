From: "Xue, Chendi" <chendi.xue@intel.com>
Subject: Checking on wip-blkin branch
Date: Tue, 9 Jun 2015 11:59:58 +0000
Message-ID: <C8CF870384EBCF4CAB89D2041A5C80B304B99DEA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63571 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbbFIMAE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 08:00:04 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Andrew Shewmaker <agshew@gmail.com>

Hi, Josh and Andrew

Today, I applied wip-blkin branch to my 4 nodes ceph setup, and created zipkin-based lttng results successfully.

The lttng output of one node looks like below:

[19:40:13.515540140] (+?.?????????) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.12ea", port_no = 0, ip = "", trace_id = 5603008495359114284, span_id = 7574382314084922818, parent_span_id = 8052152701610410440, event = "sub_op_commit_rec" }
[19:40:13.516052860] (+0.000512720) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "OSD Handling op", service_name = "PG 1.173e", port_no = 0, ip = "", trace_id = 5972487792843317983, span_id = 8783747543424673039, parent_span_id = 4641226164743578081, event = "sub_op_commit_rec" }
[19:40:13.517445543] (+0.001392683) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 6216541782147073283, span_id = 4139330703901011153, parent_span_id = 0, event = "Message allocated" }
[19:40:13.517464397] (+0.000018854) aceph01 zipkin:keyval: { cpu_id = 0 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 6216541782147073283, span_id = 4139330703901011153, parent_span_id = 0, key = "Type", val = "MOSDOp" }
[19:40:13.517466586] (+0.000002189) aceph01 zipkin:keyval: { cpu_id = 0 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 6216541782147073283, span_id = 4139330703901011153, parent_span_id = 0, key = "Reqid", val = "client.24276.0:517" }
[19:40:13.517470247] (+0.000003661) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 6216541782147073283, span_id = 4139330703901011153, parent_span_id = 0, event = "message_read" }
[19:40:13.517551767] (+0.000081520) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "OSD Handling op", service_name = "osd.6", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "waiting_on_osdmap" }
[19:40:13.517558902] (+0.000007135) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "OSD Handling op", service_name = "osd.6", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "handling_op" }
[19:40:13.517582555] (+0.000023653) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "enqueuing_op" }
[19:40:13.517592939] (+0.000010384) aceph01 zipkin:timestamp: { cpu_id = 0 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "enqueued_op" }
[19:40:13.517610258] (+0.000017319) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "dequeuing_op" }
[19:40:13.517631460] (+0.000021202) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "starting_request" }
[19:40:13.517635339] (+0.000003879) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "handling_message" }
[19:40:13.517637085] (+0.000001746) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "do_op" }
[19:40:13.517638907] (+0.000001822) aceph01 zipkin:keyval: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "osd.6", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, key = "object", val = "rbd_data.5e7b7ca40890.000000000000007d" }
[19:40:13.517677284] (+0.000038377) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "executing_ctx" }
[19:40:13.517717674] (+0.000040390) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "Main", service_name = "MOSDOpReply", port_no = 0, ip = "0.0.0.0", trace_id = 6216541782147073283, span_id = 2923417568587988974, parent_span_id = 389191001414244146, event = "Message allocated" }
[19:40:13.517721865] (+0.000004191) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "issuing_repop" }
[19:40:13.517728168] (+0.000006303) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "issuing_replication" }
[19:40:13.517742523] (+0.000014355) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "sub_op_sent | waiting for subops from 23" }
[19:40:13.517867388] (+0.000124865) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "Journal access", service_name = "Journal (/dev/sdh2)", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 5949552981320957406, parent_span_id = 389191001414244146, event = "commit_queued_for_journal_write" }
[19:40:13.517879771] (+0.000012383) aceph01 zipkin:timestamp: { cpu_id = 3 }, { trace_name = "OSD Handling op", service_name = "PG 1.c6d", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 389191001414244146, parent_span_id = 4139330703901011153, event = "dequeued_op" }
[19:40:13.517921734] (+0.000041963) aceph01 zipkin:timestamp: { cpu_id = 4 }, { trace_name = "OSD Handling op", service_name = "PG 1.204", port_no = 0, ip = "", trace_id = 7400594096956513409, span_id = 6293528614396127061, parent_span_id = 8738710816442983260, event = "sub_op_commit_rec" }
[19:40:13.517951799] (+0.000030065) aceph01 zipkin:timestamp: { cpu_id = 7 }, { trace_name = "Journal access", service_name = "Journal (/dev/sdh2)", port_no = 0, ip = "", trace_id = 6216541782147073283, span_id = 5949552981320957406, parent_span_id = 389191001414244146, event = "write_thread_in_journal_buffer" }
[19:40:13.517977726] (+0.000025927) aceph01 zipkin:timestamp: { cpu_id = 4 }, { trace_name = "Main", service_name = "MOSDOpReply", port_no = 0, ip = "0.0.0.0", trace_id = 7400594096956513409, span_id = 6966407715853117252, parent_span_id = 6293528614396127061, event = "Message allocated" }
[19:40:13.517993525] (+0.000015799) aceph01 zipkin:timestamp: { cpu_id = 4 }, { trace_name = "Main", service_name = "MOSDOp", port_no = 0, ip = "0.0.0.0", trace_id = 7400594096956513409, span_id = 8738710816442983260, parent_span_id = 0, event = "replied_commit" }
[19: ... 

Since we wanna using this latency analyzing methodology on further release or on keyvalue store and newstore.
I am wondering what is the gap to merge blkin into master? Can I help to rebase to master, so we can merge this branch? 

Thanks so much !

Best Regards,
-Chendi

