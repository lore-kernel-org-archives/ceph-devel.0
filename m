From: Jean-Charles LOPEZ <jc.lopez-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Cache tier unable to auto flush data to storage
	tier
Date: Sat, 13 Sep 2014 17:42:04 -0700
Message-ID: <37A9B8C7-FCB0-4389-94A0-CE4CDAC90B35@inktank.com>
References: <6F0091EE-47F9-49CC-9C34-13A873C01F43@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6F0091EE-47F9-49CC-9C34-13A873C01F43-Gn+qtVAUx6s@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Karan,

May be setting the dirty byte ratio (flush) and the full ratio (eviction). Just try to see if it makes any difference
- cache_target_dirty_ratio .1
- cache_target_full_ratio .2

Tune the percentage as desired relatively to target_max_bytes and target_max_objects. The first threshold reached will trigger flush or eviction (num objects or num bytes)

JC



On Sep 13, 2014, at 15:23, Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org> wrote:

> Hello Cephers
> 
> I have created a Cache pool and looks like cache tiering agent is not able to flush/evict data as per defined policy. However when i manually evict / flush data , it migrates data from cache-tier to storage-tier
> 
> Kindly advice if there is something wrong with policy or anything else i am missing.
> 
> Ceph Version: 0.80.5
> OS : Cent OS 6.4
> 
> Cache pool created using the following commands :
> 
> ceph osd tier add data cache-pool 
> ceph osd tier cache-mode cache-pool writeback
> ceph osd tier set-overlay data cache-pool
> ceph osd pool set cache-pool hit_set_type bloom
> ceph osd pool set cache-pool hit_set_count 1
> ceph osd pool set cache-pool hit_set_period 300
> ceph osd pool set cache-pool target_max_bytes 10000
> ceph osd pool set cache-pool target_max_objects 100
> ceph osd pool set cache-pool cache_min_flush_age 60
> ceph osd pool set cache-pool cache_min_evict_age 60
> 
> 
> [root@ceph-node1 ~]# date
> Sun Sep 14 00:49:59 EEST 2014
> [root@ceph-node1 ~]# rados -p data  put file1 /etc/hosts
> [root@ceph-node1 ~]# rados -p data ls
> [root@ceph-node1 ~]# rados -p cache-pool ls
> file1
> [root@ceph-node1 ~]#
> 
> 
> [root@ceph-node1 ~]# date
> Sun Sep 14 00:59:33 EEST 2014
> [root@ceph-node1 ~]# rados -p data ls
> [root@ceph-node1 ~]# 
> [root@ceph-node1 ~]# rados -p cache-pool ls
> file1
> [root@ceph-node1 ~]#
> 
> 
> [root@ceph-node1 ~]# date
> Sun Sep 14 01:08:02 EEST 2014
> [root@ceph-node1 ~]# rados -p data ls
> [root@ceph-node1 ~]# rados -p cache-pool ls
> file1
> [root@ceph-node1 ~]#
> 
> 
> 
> [root@ceph-node1 ~]# rados -p cache-pool  cache-flush-evict-all
> file1
> [root@ceph-node1 ~]#
> [root@ceph-node1 ~]# rados -p data ls
> file1
> [root@ceph-node1 ~]# rados -p cache-pool ls
> [root@ceph-node1 ~]#
> 
> 
> Regards
> Karan Singh
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
