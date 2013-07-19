From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Optimize Ceph cluster (kernel, osd, rbd)
Date: Sat, 20 Jul 2013 02:11:30 +0700
Message-ID: <51E98F62.8050800@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1576932015=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, MinhCD <minhcd-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1576932015==
Content-Type: multipart/alternative;
 boundary="------------060108000204000509050801"

This is a multi-part message in MIME format.
--------------060108000204000509050801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

I have *3 nodes (running MON and MDS)*
and *6 data nodes ( 84 OSDs**)*
Each data nodes has configuraions:
   - CPU: 24 processor * Core Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
   - RAM: 32GB
   - Disk: 14*4TB
(14disks *4TB *6 data nodes= 84 OSDs)

To optimize Ceph Cluster, *I adjusted some kernel arguments* (nr_request 
in queue and increated read throughput):

#Adjust nr_request in queue (staying in mem - default is 128)
     echo 1024 > /sys/block/sdb/queue/nr_requests
     echo noop > /sys/block/sda/queue/scheduler   (default= noop 
deadline [cfq])
#Increase read throughput  (default: 128)
     echo "512" > /sys/block/*/queue/read_ahead_kb

And, *tuning Ceph configuraion options below:*

[client]

      rbd cache = true
      rbd cache size = 536870912
      rbd cache max dirty = 134217728
      rbd cache target dirty = 33554432
      rbd cache max dirty age = 5

[osd]
     osd data = /var/lib/ceph/osd/cloud-$id
     osd journal = /var/lib/ceph/osd/cloud-$id/journal
     osd journal size = 10000
     osd mkfs type = xfs
     osd mkfs options xfs = "-f -i size=2048"
     osd mount options xfs = "rw,noatime,inode64,logbsize=250k"

     keyring = /var/lib/ceph/osd/cloud-$id/keyring.osd.$id
#increasing the number may increase the request processing rate
     osd op threads = 24
#The number of disk threads, which are used to perform background disk 
intensive OSD operations such as scrubbing and snap trimming
     osd disk threads =24
#The number of active recovery requests per OSD at one time. More 
requests will accelerate recovery, but the requests places an increased 
load on the cluster.
     osd recovery max active =1
#writing direct to the journal.
#Allow use of libaio to do asynchronous writes
     journal dio = true
     journal aio = true
#Synchronization interval:
#The maximum/minimum interval in seconds for synchronizing the filestore.
     filestore max sync interval = 100
     filestore min sync interval = 50
#Defines the maximum number of in progress operations the file store 
accepts before blocking on queuing new operations.
     filestore queue max ops = 2000
#The maximum number of bytes for an operation
     filestore queue max bytes = 536870912
#The maximum number of operations the filestore can commit.
     filestore queue committing max ops = 2000 (default =500)
#The maximum number of bytes the filestore can commit.
     filestore queue committing max bytes = 536870912
#When you add or remove Ceph OSD Daemons to a cluster, the CRUSH 
algorithm will want to rebalance the cluster by moving placement groups 
to or from Ceph OSD Daemons to restore the balance. The process of 
migrating placement groups and the objects they contain can reduce the 
cluster's operational performance considerably. To maintain operational 
performance, Ceph performs this migration with 'backfilling', which 
allows Ceph to set backfill operations to a lower priority than requests 
to read or write data.
     osd max backfills = 1


Tomorrow, I'm going to implement Ceph Cluster,
I have very little experience in managing Ceph. So, I hope someone give 
me advices about above arguments and guide me how to best optimize ceph 
cluster?

Thank you so much!
--tuantaba




--------------060108000204000509050801
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi everyone,<br>
    <br>
    I have <b>3 nodes (running MON and MDS)</b><br>
    and&nbsp; <b>6 data nodes ( 84 OSDs</b><b> )</b><br>
    Each data nodes has configuraions:<br>
    &nbsp; - CPU: 24 processor * Core Intel(R) Xeon(R) CPU E5-2620 0 @
    2.00GHz<br>
    &nbsp; - RAM: 32GB<br>
    &nbsp; - Disk: 14*4TB<br>
    (14disks *4TB *6 data nodes= 84 OSDs)<br>
    <br>
    To optimize Ceph Cluster, <b>I adjusted some kernel arguments</b>
    (nr_request in queue and increated read throughput):<br>
    <br>
    #Adjust nr_request in queue (staying in mem - default is 128) <br>
    &nbsp;&nbsp;&nbsp; echo 1024 &gt; /sys/block/sdb/queue/nr_requests<br>
    &nbsp;&nbsp;&nbsp; echo noop &gt; /sys/block/sda/queue/scheduler&nbsp;&nbsp; (default= noop
    deadline [cfq])<br>
    #Increase read throughput&nbsp; (default: 128)<br>
    &nbsp;&nbsp;&nbsp; echo "512" &gt; /sys/block/*/queue/read_ahead_kb<br>
    <br>
    And, <b>tuning Ceph configuraion options below:</b><br>
    <br>
    [client]<br>
    <blockquote>&nbsp;rbd cache = true<br>
      &nbsp;rbd cache size = 536870912<br>
      &nbsp;rbd cache max dirty = 134217728<br>
      &nbsp;rbd cache target dirty = 33554432<br>
      &nbsp;rbd cache max dirty age = 5<br>
    </blockquote>
    [osd]<br>
    &nbsp;&nbsp;&nbsp; osd data = /var/lib/ceph/osd/cloud-$id<br>
    &nbsp;&nbsp;&nbsp; osd journal = /var/lib/ceph/osd/cloud-$id/journal<br>
    &nbsp;&nbsp;&nbsp; osd journal size = 10000<br>
    &nbsp;&nbsp;&nbsp; osd mkfs type = xfs<br>
    &nbsp;&nbsp;&nbsp; osd mkfs options xfs = "-f -i size=2048"<br>
    &nbsp;&nbsp;&nbsp; osd mount options xfs = "rw,noatime,inode64,logbsize=250k"<br>
    <br>
    &nbsp;&nbsp;&nbsp; keyring = /var/lib/ceph/osd/cloud-$id/keyring.osd.$id<br>
    #increasing the number may increase the request processing rate<br>
    &nbsp;&nbsp;&nbsp; osd op threads = 24<br>
    #The number of disk threads, which are used to perform background
    disk intensive OSD operations such as scrubbing and snap trimming<br>
    &nbsp;&nbsp;&nbsp; osd disk threads =24<br>
    #The number of active recovery requests per OSD at one time. More
    requests will accelerate recovery, but the requests places an
    increased load on the cluster.<br>
    &nbsp;&nbsp;&nbsp; osd recovery max active =1<br>
    #writing direct to the journal.<br>
    #Allow use of libaio to do asynchronous writes<br>
    &nbsp;&nbsp;&nbsp; journal dio = true<br>
    &nbsp;&nbsp;&nbsp; journal aio = true<br>
    #Synchronization interval:<br>
    #The maximum/minimum interval in seconds for synchronizing the
    filestore.<br>
    &nbsp;&nbsp;&nbsp; filestore max sync interval = 100<br>
    &nbsp;&nbsp;&nbsp; filestore min sync interval = 50<br>
    #Defines the maximum number of in progress operations the file store
    accepts before blocking on queuing new operations.<br>
    &nbsp;&nbsp;&nbsp; filestore queue max ops = 2000<br>
    #The maximum number of bytes for an operation<br>
    &nbsp;&nbsp;&nbsp; filestore queue max bytes = 536870912<br>
    #The maximum number of operations the filestore can commit.<br>
    &nbsp;&nbsp;&nbsp; filestore queue committing max ops = 2000 (default =500)<br>
    #The maximum number of bytes the filestore can commit.<br>
    &nbsp;&nbsp;&nbsp; filestore queue committing max bytes = 536870912<br>
    #When you add or remove Ceph OSD Daemons to a cluster, the CRUSH
    algorithm will want to rebalance the cluster by moving placement
    groups to or from Ceph OSD Daemons to restore the balance. The
    process of migrating placement groups and the objects they contain
    can reduce the cluster&#8217;s operational performance considerably. To
    maintain operational performance, Ceph performs this migration with
    &#8216;backfilling&#8217;, which allows Ceph to set backfill operations to a
    lower priority than requests to read or write data.<br>
    &nbsp;&nbsp;&nbsp; osd max backfills = 1<br>
    <br>
    <br>
    Tomorrow, I'm going to implement Ceph Cluster,<br>
    I have very little experience in managing Ceph. So, I hope someone
    give me advices about above arguments and guide me how to best
    optimize ceph cluster?<br>
    <br>
    Thank you so much!<br>
    --tuantaba<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------060108000204000509050801--

--===============1576932015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1576932015==--
