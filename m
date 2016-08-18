From: Burkhard Linke <Burkhard.Linke@computational.bio.uni-giessen.de>
Subject: Monitor crash after changing replicated crush rulesets in jewel
Date: Thu, 18 Aug 2016 13:58:17 +0200
Message-ID: <2a55e540-9ec3-9d60-d2ff-7af11ff38385@computational.bio.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:52414 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936AbcHRMOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Aug 2016 08:14:09 -0400
Received: from mailgw32.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP for ceph-devel@vger.kernel.org; Thu, 18 Aug 2016 13:58:24 +0200
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw32.hrz.uni-giessen.de (Postfix) with ESMTP id 80720576D62
	for <ceph-devel@vger.kernel.org>; Thu, 18 Aug 2016 13:58:17 +0200 (CEST)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP for ceph-devel@vger.kernel.org; Thu, 18 Aug 2016 13:58:17 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've stumpled across a problem in jewel with respect to crush rulesets. 
Our setup currently define two replicated rulesets:
# ceph osd crush rule list
[
     "replicated_ruleset",
     "replicated_ssd_only",
     "six_two_ec"
]
(third ruleset is a EC ruleset)
Both rulesets are quite simple:
# ceph osd crush rule dump replicated_ssd_only
{
     "rule_id": 1,
     "rule_name": "replicated_ssd_only",
     "ruleset": 2,
     "type": 1,
     "min_size": 2,
     "max_size": 4,
     "steps": [
         {
             "op": "take",
             "item": -9,
             "item_name": "ssd"
         },
         {
             "op": "chooseleaf_firstn",
             "num": 0,
             "type": "host"
         },
         {
             "op": "emit"
         }
     ]
}

# ceph osd crush rule dump replicated_ruleset
{
     "rule_id": 0,
     "rule_name": "replicated_ruleset",
     "ruleset": 0,
     "type": 1,
     "min_size": 1,
     "max_size": 10,
     "steps": [
         {
             "op": "take",
             "item": -3,
             "item_name": "default"
         },
         {
             "op": "chooseleaf_firstn",
             "num": 0,
             "type": "host"
         },
         {
             "op": "emit"
         }
     ]
}
The corresponding crush tree has two roots:
ID  WEIGHT    TYPE NAME                    UP/DOWN REWEIGHT 
PRIMARY-AFFINITY
  -9   5.97263 root ssd
-18   0.53998     host ceph-storage-06-ssd
  86   0.26999         osd.86                    up  1.00000 1.00000
  88   0.26999         osd.88                    up  1.00000 1.00000
-19   0.53998     host ceph-storage-05-ssd
100   0.26999         osd.100                   up  1.00000 1.00000
  99   0.26999         osd.99                    up  1.00000 1.00000
...
  -3 531.43933 root default
-10  61.87991     host ceph-storage-02
  35   5.45999         osd.35                    up  1.00000 1.00000
  74   5.45999         osd.74                    up  1.00000 1.00000
111   5.45999         osd.111                   up  1.00000 1.00000
112   5.45999         osd.112                   up  1.00000 1.00000
113   5.45999         osd.113                   up  1.00000 1.00000
114   5.45999         osd.114                   up  1.00000 1.00000
115   5.45999         osd.115                   up  1.00000 1.00000
116   5.45999         osd.116                   up  1.00000 1.00000
117   5.45999         osd.117                   up  1.00000 1.00000
118   3.64000         osd.118                   up  1.00000 1.00000
119   5.45999         osd.119                   up  1.00000 1.00000
120   3.64000         osd.120                   up  1.00000 1.00000
....
So the first (default) ruleset should use spinning rust, the second one 
should use the SSDs. Pretty standard setup for SSDs colocated with HDDs.

After changing the crush ruleset for an existing pool ('.log' from 
radosgw) to replicated_ssd_only, two of three mons crashed leaving the 
cluster unaccessible. Log file content:

....
    -13> 2016-08-18 12:22:10.800961 7fb7b5ae2700 10 log_client 
_send_to_monlog to self
    -12> 2016-08-18 12:22:10.800961 7fb7b5ae2700 10 log_client log_queue 
is 8 last_log 8 sent 7 num 8 unsent 1 sending 1
    -11> 2016-08-18 12:22:10.800963 7fb7b5ae2700 10 log_client will send 
2016-08-18 12:22:10.800960 mon.1 192.168.6.133:6789/0 8 : audit [I
NF] from='client.3839479 :/0' entity='unknown.' cmd=[{"var": 
"crush_ruleset", "prefix": "osd pool set", "pool": ".log", "val": "2"}]: 
dispa
tch
    -10> 2016-08-18 12:22:10.800969 7fb7b5ae2700  1 -- 
192.168.6.133:6789/0 --> 192.168.6.133:6789/0 -- log(1 entries from seq 
8 at 2016-08-
18 12:22:10.800960) v1 -- ?+0 0x7fb7cc4318c0 con 0x7fb7cb5f6e80
     -9> 2016-08-18 12:22:10.800977 7fb7b5ae2700  5 -- op tracker -- 
seq: 92, time: 2016-08-18 12:22:10.800976, event: psvc:dispatch, op: mo
n_command({"var": "crush_ruleset", "prefix": "osd pool set", "pool": 
".log", "val": "2"} v 0)
     -8> 2016-08-18 12:22:10.800980 7fb7b5ae2700  5 
mon.ceph-storage-05@1(leader).paxos(paxos active c 79420671..79421306) 
is_readable = 1 -
  now=2016-08-18 12:22:10.800980 lease_expire=2016-08-18 12:22:15.796784 
has v0 lc 79421306
     -7> 2016-08-18 12:22:10.800986 7fb7b5ae2700  5 -- op tracker -- 
seq: 92, time: 2016-08-18 12:22:10.800986, event: osdmap:preprocess_que
ry, op: mon_command({"var": "crush_ruleset", "prefix": "osd pool set", 
"pool": ".log", "val": "2"} v 0)
     -6> 2016-08-18 12:22:10.800992 7fb7b5ae2700  5 -- op tracker -- 
seq: 92, time: 2016-08-18 12:22:10.800992, event: osdmap:preprocess_com
mand, op: mon_command({"var": "crush_ruleset", "prefix": "osd pool set", 
"pool": ".log", "val": "2"} v 0)
     -5> 2016-08-18 12:22:10.801022 7fb7b5ae2700  5 -- op tracker -- 
seq: 92, time: 2016-08-18 12:22:10.801022, event: osdmap:prepare_update
, op: mon_command({"var": "crush_ruleset", "prefix": "osd pool set", 
"pool": ".log", "val": "2"} v 0)
     -4> 2016-08-18 12:22:10.801029 7fb7b5ae2700  5 -- op tracker -- 
seq: 92, time: 2016-08-18 12:22:10.801029, event: osdmap:prepare_comman
d, op: mon_command({"var": "crush_ruleset", "prefix": "osd pool set", 
"pool": ".log", "val": "2"} v 0)
     -3> 2016-08-18 12:22:10.801041 7fb7b5ae2700  5 -- op tracker -- 
seq: 92, time: 2016-08-18 12:22:10.801041, event: osdmap:prepare_comman
d_impl, op: mon_command({"var": "crush_ruleset", "prefix": "osd pool 
set", "pool": ".log", "val": "2"} v 0)
     -2> 2016-08-18 12:22:10.802750 7fb7af185700  1 -- 
192.168.6.133:6789/0 >> :/0 pipe(0x7fb7cc373400 sd=56 :6789 s=0 pgs=0 
cs=0 l=0 c=0x7f
b7cc34aa80).accept sd=56 192.168.6.132:53238/0
     -1> 2016-08-18 12:22:10.802877 7fb7af185700  2 -- 
192.168.6.133:6789/0 >> 192.168.6.132:6800/21078 pipe(0x7fb7cc373400 
sd=56 :6789 s=2
pgs=89 cs=1 l=1 c=0x7fb7cc34aa80).reader got KEEPALIVE2 2016-08-18 
12:22:10.802927
      0> 2016-08-18 12:22:10.802989 7fb7b5ae2700 -1 *** Caught signal 
(Segmentation fault) **
  in thread 7fb7b5ae2700 thread_name:ms_dispatch

  ceph version 10.2.2 (45107e21c568dd033c2f0a3107dec8f0b0e58374)
  1: (()+0x5055ea) [0x7fb7bfc9d5ea]
  2: (()+0xf100) [0x7fb7be520100]
  3: (OSDMonitor::prepare_command_pool_set(std::map<std::string, 
boost::variant<std::string, bool, long, double, std::vector<std::string, st
d::allocator<std::string> >, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::va
riant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, b
oost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::v
ariant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_>, std::less<std::string>, 
std::allocator<std::pair<std::string
const, boost::variant<std::string, bool, long, double, 
std::vector<std::string, std::allocator<std::string> >, 
boost::detail::variant::void
_, boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
l::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::voi
d_, boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, boost::deta
il::variant::void_> > > >&, std::basic_stringstream<char, 
std::char_traits<char>, std::allocator<char> >&)+0x122f) [0x7fb7bfaa997f]
  4: (OSDMonitor::prepare_command_impl(std::shared_ptr<MonOpRequest>, 
std::map<std::string, boost::variant<std::string, bool, long, double,
std::vector<std::string, std::allocator<std::string> >, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::varian
t::void_, boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_>, 
std::less<std::string>, std::allocator<std::pair<std::string const, 
boost::variant<std::string, bool, long, double, std::vector<std::string, 
std::allocator<std::string> >, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_, 
boost::detail::variant::void_, boost::detail::variant::void_> > > 
 >&)+0xf02c) [0x7fb7bfab968c]
  5: (OSDMonitor::prepare_command(std::shared_ptr<MonOpRequest>)+0x64f) 
[0x7fb7bfabe46f]
  6: (OSDMonitor::prepare_update(std::shared_ptr<MonOpRequest>)+0x307) 
[0x7fb7bfabffc7]
  7: (PaxosService::dispatch(std::shared_ptr<MonOpRequest>)+0xe0b) 
[0x7fb7bfa6e60b]
  8: (Monitor::handle_command(std::shared_ptr<MonOpRequest>)+0x1d22) 
[0x7fb7bfa2a4f2]
  9: (Monitor::dispatch_op(std::shared_ptr<MonOpRequest>)+0x33b) 
[0x7fb7bfa3617b]
  10: (Monitor::_ms_dispatch(Message*)+0x6c9) [0x7fb7bfa37519]
  11: (Monitor::handle_forward(std::shared_ptr<MonOpRequest>)+0x89c) 
[0x7fb7bfa359ac]
  12: (Monitor::dispatch_op(std::shared_ptr<MonOpRequest>)+0xc70) 
[0x7fb7bfa36ab0]
  13: (Monitor::_ms_dispatch(Message*)+0x6c9) [0x7fb7bfa37519]
  14: (Monitor::ms_dispatch(Message*)+0x23) [0x7fb7bfa58063]
  15: (DispatchQueue::entry()+0x78a) [0x7fb7bfeb0d1a]
  16: (DispatchQueue::DispatchThread::entry()+0xd) [0x7fb7bfda620d]
  17: (()+0x7dc5) [0x7fb7be518dc5]
  18: (clone()+0x6d) [0x7fb7bcde0ced]

Complete log is available on request. I was able to recover the cluster 
by fencing the third still active mon (shutdown of network interface) 
and restarting the other two mons. They keep on crashing after a short 
time with the same stack trace until I was able to issue the command for 
changing the crush ruleset back to the 'replicated_ruleset'. After 
reenabling the network interface and restarting the services, the third 
mon (and the OSD on that host) rejoined the cluster.

Regards,
Burkhard


