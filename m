From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Scaling RBD module
Date: Tue, 17 Sep 2013 22:30:28 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com>
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
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
I am running Ceph on a 3 node cluster and each of my server node is running 10 OSDs, one for each disk. I have one admin node and all the nodes are connected with 2 X 10G network. One network is for cluster and other one configured as public network.

Here is the status of my cluster.

~/fio_test# ceph -s

  cluster b2e0b4db-6342-490e-9c28-0aadf0188023
   health HEALTH_WARN clock skew detected on mon. <server-name-2>, mon. <server-name-3>
   monmap e1: 3 mons at {<server-name-1>=xxx.xxx.xxx.xxx:6789/0, <server-name-2>=xxx.xxx.xxx.xxx:6789/0, <server-name-3>=xxx.xxx.xxx.xxx:6789/0}, election epoch 64, quorum 0,1,2 <server-name-1>,<server-name-2>,<server-name-3>
   osdmap e391: 30 osds: 30 up, 30 in
    pgmap v5202: 30912 pgs: 30912 active+clean; 8494 MB data, 27912 MB used, 11145 GB / 11172 GB avail
   mdsmap e1: 0/0/1 up


I started with rados bench command to benchmark the read performance of this Cluster on a large pool (~10K PGs) and found that each rados client has a limitation. Each client can only drive up to a certain mark. Each server  node cpu utilization shows it is  around 85-90% idle and the admin node (from where rados client is running) is around ~80-85% idle. I am trying with 4K object size.

Now, I started running more clients on the admin node and the performance is scaling till it hits the client cpu limit. Server still has the cpu of 30-35% idle. With small object size I must say that the ceph per osd cpu utilization is not promising!

After this, I started testing the rados block interface with kernel rbd module from my admin node.
I have created 8 images mapped on the pool having around 10K PGs and I am not able to scale up the performance by running fio (either by creating a software raid or running on individual /dev/rbd* instances). For example, running multiple fio instances (one in /dev/rbd1 and the other in /dev/rbd2)  the performance I am getting is half of what I am getting if running one instance. Here is my fio job script.

[random-reads]
ioengine=libaio
iodepth=32
filename=/dev/rbd1
rw=randread
bs=4k
direct=1
size=2G
numjobs=64

Let me know if I am following the proper procedure or not.

But, If my understanding is correct, kernel rbd module is acting as a client to the cluster and in one admin node I can run only one of such kernel instance.
If so, I am then limited to the client bottleneck that I stated earlier. The cpu utilization of the server side is around 85-90% idle, so, it is clear that client is not driving.

My question is, is there any way to hit the cluster  with more client from a single box while testing the rbd module ?

Appreciate, if anybody can help me on this.

Thanks & Regards
Somnath



________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
