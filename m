From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Scaling radosgw module
Date: Fri, 20 Sep 2013 21:57:46 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A8A7@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, "yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
I am running Ceph on a 3 node cluster and each of my server node is running 10 OSDs, one for each disk. I have one admin node and all the nodes are connected with 2 X 10G network. One network is for cluster and other one configured as public network.

All the OSD journals are on SSDs.

I started with rados bench command to benchmark the read performance of this Cluster on a large pool (~10K PGs) and found that each rados client has a limitation. Each client can only drive up to a certain mark. Each server  node cpu utilization shows it is  around 85-90% idle and the admin node (from where rados client is running) is around ~80-85% idle. I am trying with 4K object size.

I started running more clients on the admin node and the performance is scaling till it hits the client cpu limit. Server still has the cpu of 30-35% idle.

Now, I am behind radosgw and in one of the server node I installed the required modules like apache, fastcgi, radosgw etc.  I configured swift bench and started benchmarking. Here is my swift-bench job script.

[bench]
auth = http://<my-server>/auth
user = somroy:swift
key = UbJl9o+OPnzGaRbgqkS9OtPQ01TkAXAeA9RmVzVt
concurrency = 64
object_size = 4096
num_objects = 1000
num_gets = 200000
delete = yes
auth_version = 1.0


First of all,  the read performance I am getting with one radosgw is more than 5x slower than what I am getting with one rbd client or one rados bench client. Is this expected ? Here is my ceph.conf radosgw config option.

[client.radosgw.gateway]
host = emsserver1
keyring = /etc/ceph/keyring.radosgw.gateway
rgw_socket_path = /tmp/radosgw.sock
log_file = /var/log/ceph/radosgw.log
rgw_dns_name = <ip>
rgw_ops_log_rados = false
debug_rgw = 0
rgw_thread_pool_size = 300

The server node (where radosgw is also present) avg cpu utilization is very low (~75-80% idle). Out of the ~20% consumption, I saw radosgw is consuming bulk of the cpu in the node and ceph-osds are not much. The other two server node is ~95% idle ; 10 ceph-osds are consuming this of total 5% of cpu !!

So, clearly, I am not able to generate much load on the cluster.
So, I tried to run multiple swift-bench instances with the same job , all hitting the single radosgw instance. I saw no improvement on the performance, each instance iops is almost now = (single instance iop/number of swift-bench instance). The aggregated iops is remaining almost same as of single instance.

This means we are hitting the single client instance limit here too.
My question is, for all the requests radosgw is opening only single client connection to the object store ?
If so, is there any configuration like 'noshare' option in case of rbd that Josh pointed out in my earlier mail ?

If not, how a single radosgw instance will scale ?

Appreciate, if anybody can help me on this.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
