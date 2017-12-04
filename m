From: Yoann Moulin <yoann.moulin-p8DiymsW2f8@public.gmane.org>
Subject: [Docs] s/ceph-disk/ceph-volume/g ?
Date: Mon, 4 Dec 2017 09:34:32 +0100
Message-ID: <dd203eff-a24d-ebbd-29fe-bb1e6273d1d7@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: fr-CH
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello,

By the fact ceph-disk is now deprecated, that would be great to update documentation to have also processes with ceph-volume.

for example :

add-or-rm-osds => http://docs.ceph.com/docs/master/rados/operations/add-or-rm-osds/

bluestore-migration => http://docs.ceph.com/docs/master/rados/operations/bluestore-migration/

In my opinion, documentation for luminous branch should keep both options (ceph-disk and ceph-volume) but with a warning message to
encourage people to use ceph-volume instead of ceph-disk.

I guess, there is plenty of reference to ceph-disk that need to be updated.

-- 
Yoann Moulin
EPFL IC-IT
