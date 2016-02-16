From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Messenger issues with Kernel RBD client
Date: Tue, 16 Feb 2016 10:57:23 +0000
Message-ID: <BLUPR0201MB19081EB79465EF9AA20A6FBCE2AD0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0071.outbound.protection.outlook.com ([65.55.169.71]:34472
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932072AbcBPK50 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 05:57:26 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Apologies for the long mail.

We are testing the latest jewel branch with kernel RBD in our test
clusters. When running some benchmark tests with various tools like
vdbench and medusa, we are facing  io's getting timed out and some
messenger issues when osd's in a particular node are not reachable(crashed).

we simulated the same problem by killing the osds in a specific node.
Here is some information about the use case what we are following.
please note, steps listed are used for reproducing the problem.

1. created 4-6 rbd images of size 10g each and mapped them a single client.
2. Run VDBench or medusa on all the images in parallel.
3. When the IOs are in progress, we killed(pkill -f ceph-osd) all the
osds in that node. It has 4 osds running in that node.
4. IO's started timing out the application side.

# ceph osd tree
ID WEIGHT   TYPE NAME              UP/DOWN REWEIGHT PRIMARY-AFFINITY
-1 90.78418 root default
-2 13.96680     host host1
 0  6.98340         osd.0               up  1.00000          1.00000
 5  6.98340         osd.5               up  1.00000          1.00000
-3 20.95020     host host2
 2  6.98340         osd.2               up  1.00000          1.00000
 6  6.98340         osd.6               up  1.00000          1.00000
 9  6.98340         osd.9               up  1.00000          1.00000
-4 27.93359     host host3
 1  6.98340         osd.1               up  1.00000          1.00000
 4  6.98340         osd.4               up  1.00000          1.00000
 8  6.98340         osd.8               up  1.00000          1.00000
11  6.98340         osd.11              up  1.00000          1.00000
-5 27.93359     host host4
 3  6.98340         osd.3               up  1.00000          1.00000
 7  6.98340         osd.7               up  1.00000          1.00000
10  6.98340         osd.10              up  1.00000          1.00000
12  6.98340         osd.12              up  1.00000          1.00000


Killed the osds on host4 to simulate the problem. VDBench started to
report timeouts and eventually exits with IO time out.
Looking at the inflight IOs from the client, below is the list.  After
sometime all the requests are getting serviced, but that is taking more
than 3-4 hours in some cases.

:/sys/kernel/debug/ceph/9bc5710e-ec4e-40c8-ac18-d9c78e3174a3.client14822# cat
osdc
763941  osd2    0.510a598c
rbd_data.37675e18ec5c.0000000000000000          set-alloc-hint,write
763944  osd2    0.510a598c
rbd_data.37675e18ec5c.0000000000000000          set-alloc-hint,write
763946  osd2    0.510a598c
rbd_data.37675e18ec5c.0000000000000000          set-alloc-hint,write
763981  osd9    0.4502d37
rbd_data.37655e18ec5c.0000000000000000          set-alloc-hint,write
763982  osd2    0.510a598c
rbd_data.37675e18ec5c.0000000000000000          set-alloc-hint,write
763983  osd7    0.d1d0c058
rbd_data.37645e18ec5c.0000000000000001          set-alloc-hint,write
763987  osd12   0.116555eb
rbd_data.37655e18ec5c.0000000000000001          set-alloc-hint,write
763989  osd7    0.d1d0c058
rbd_data.37645e18ec5c.0000000000000001          set-alloc-hint,write
763990  osd12   0.116555eb
rbd_data.37655e18ec5c.0000000000000001          set-alloc-hint,write
763991  osd10   0.a9ced827
rbd_data.37675e18ec5c.0000000000000001          set-alloc-hint,write
763997  osd7    0.d1d0c058
rbd_data.37645e18ec5c.0000000000000001          set-alloc-hint,write
763998  osd7    0.d1d0c058
rbd_data.37645e18ec5c.0000000000000001          set-alloc-hint,write
764000  osd12   0.116555eb
rbd_data.37655e18ec5c.0000000000000001          set-alloc-hint,write
764001  osd12   0.116555eb
rbd_data.37655e18ec5c.0000000000000001          set-alloc-hint,write
764005  osd10   0.a9ced827
rbd_data.37675e18ec5c.0000000000000001          set-alloc-hint,write
764006  osd10   0.a9ced827
rbd_data.37675e18ec5c.0000000000000001          set-alloc-hint,write
764007  osd10   0.a9ced827
rbd_data.37675e18ec5c.0000000000000001          set-alloc-hint,write
764012  osd9    0.fe127905
rbd_data.3762197d8e1.0000000000000000           set-alloc-hint,write
764015  osd9    0.fe127905
rbd_data.3762197d8e1.0000000000000000           set-alloc-hint,write
764016  osd9    0.fe127905
rbd_data.3762197d8e1.0000000000000000           set-alloc-hint,write
764017  osd9    0.fe127905
rbd_data.3762197d8e1.0000000000000000           set-alloc-hint,write
764019  osd9    0.4502d37
rbd_data.37655e18ec5c.0000000000000000          set-alloc-hint,write
764020  osd9    0.4502d37
rbd_data.37655e18ec5c.0000000000000000          set-alloc-hint,write
764021  osd9    0.4502d37
rbd_data.37655e18ec5c.0000000000000000          set-alloc-hint,write
772683  osd12   0.217c16        rbd_header.37655e18ec5c 1'3736621547520
watch
772684  osd9    0.3488413d      rbd_header.37675e18ec5c 1'3736621547520
watch
772685  osd2    0.ddaa3a04      rbd_header.37665e18ec5c 1'3736621547520
watch
772686  osd6    0.74855881      rbd_header.3762197d8e1  1'3736621547520
watch
772687  osd4    0.f2049b15      rbd_header.37645e18ec5c 1'3736621547520
watch
779223  osd10   0.8ee2359d
rbd_data.37645e18ec5c.0000000000000004          set-alloc-hint,write
779235  osd10   0.8ee2359d
rbd_data.37645e18ec5c.0000000000000004          set-alloc-hint,write
779245  osd10   0.8ee2359d
rbd_data.37645e18ec5c.0000000000000004          set-alloc-hint,write
779256  osd10   0.8ee2359d
rbd_data.37645e18ec5c.0000000000000004          set-alloc-hint,write
785207  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785208  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785209  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785246  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785262  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785300  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785302  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write
785444  osd9    0.9e606a9
rbd_data.37632fa325d9.0000000000000002          set-alloc-hint,write


On the server end(OSD) we see the write operation been serviced and
replied to the client, but client doesn't receive the ACK for the same
write op.

# grep "763941" ceph-osd.2.log // greping with the tid.

2016-02-16 12:05:41.635471 7f998d3fe700 10 -- 10.242.50.75:6813/398594
>> 10.242.50.24:0/2005607937 pipe(0x7f998186b000 sd=105 :6813 s=2 pgs=25
cs=1 l=1 c=0x7f998187ac00).reader got message 49517 0x7f9947a9f700
osd_op(client.14822.1:763941 0.510a598c
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] snapc 0=[] ondisk+write
e897) v4
2016-02-16 12:05:41.635476 7f998d3fe700  1 -- 10.242.50.75:6813/398594
<== client.14822 10.242.50.24:0/2005607937 49517 ====
osd_op(client.14822.1:763941 0.510a598c
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] snapc 0=[] ondisk+write
e897) v4 ==== 215+0+4096 (1216556501 0 712262927) 0x7f9947a9f700 con
0x7f998187ac00
2016-02-16 12:05:41.637085 7f998d3fe700 10 -- 10.242.50.75:6813/398594
>> 10.242.50.24:0/2005607937 pipe(0x7f998186b000 sd=105 :6813 s=2 pgs=25
cs=1 l=1 c=0x7f998187ac00).reader got message 49521 0x7f995000cd00
osd_op(client.14822.1:763941 0.510a598c
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] snapc 0=[] RETRY=1
ondisk+retry+write e898) v4
2016-02-16 12:05:41.637094 7f998d3fe700  1 -- 10.242.50.75:6813/398594
<== client.14822 10.242.50.24:0/2005607937 49521 ====
osd_op(client.14822.1:763941 0.510a598c
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] snapc 0=[] RETRY=1
ondisk+retry+write e898) v4 ==== 215+0+4096 (1885975902 0 712262927)
0x7f995000cd00 con 0x7f998187ac00
2016-02-16 12:05:43.512935 7f9998bff700  1 -- 10.242.50.75:6813/398594
--> 10.242.50.24:0/2005607937 -- osd_op_reply(763941
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] v897'135726 uv135726
ondisk = 0) v6 -- ?+0 0x7f9947a9e800 con 0x7f998187ac00
2016-02-16 12:05:43.512944 7f9998bff700 20 -- 10.242.50.75:6813/398594
submit_message osd_op_reply(763941
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] v897'135726 uv135726
ondisk = 0) v6 remote, 10.242.50.24:0/2005607937, have pipe.
2016-02-16 12:05:43.512953 7f998d1fc700 20 -- 10.242.50.75:6813/398594
>> 10.242.50.24:0/2005607937 pipe(0x7f998186b000 sd=105 :6813 s=2 pgs=25
cs=1 l=1 c=0x7f998187ac00).writer encoding 50911 features
284465524124226 0x7f9947a9e800 osd_op_reply(763941
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] v897'135726 uv135726
ondisk = 0) v6
2016-02-16 12:05:43.521033 7f999fc00700  1 -- 10.242.50.75:6813/398594
--> 10.242.50.24:0/2005607937 -- osd_op_reply(763941
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] v897'135726 uv135726
ondisk = 0) v6 -- ?+0 0x7f9946495d00 con 0x7f998187ac00
2016-02-16 12:05:43.521039 7f999fc00700 20 -- 10.242.50.75:6813/398594
submit_message osd_op_reply(763941
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] v897'135726 uv135726
ondisk = 0) v6 remote, 10.242.50.24:0/2005607937, have pipe.
2016-02-16 12:05:43.521060 7f998d1fc700 20 -- 10.242.50.75:6813/398594
>> 10.242.50.24:0/2005607937 pipe(0x7f998186b000 sd=105 :6813 s=2 pgs=25
cs=1 l=1 c=0x7f998187ac00).writer encoding 50912 features
284465524124226 0x7f9946495d00 osd_op_reply(763941
rbd_data.37675e18ec5c.0000000000000000 [set-alloc-hint object_size
4194304 write_size 4194304,write 2682880~4096] v897'135726 uv135726
ondisk = 0) v6

Even retires seemed to be replied back to the client, but client is
handling the request or not received by the libceph?
Enabled logs on libceph end find any handle_reply messages, but they are
present in the kernel logs for this tid, except some keep alives been
sent to the osd. Have tried with latest stable kernel(4.4.1) to check if
any recent fixes resolves the issues, but problem still persists.

Any clues, how to debug this problem? Tried running wireshark to analyze
the acks and replies, but not able to parse the logs correctly with the
ceph messages alone.
Any help would be much appreciated in this case.

Thanks,
Varada
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
