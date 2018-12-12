From: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Deploying an Active/Active NFS Cluster over
 CephFS
Date: Wed, 12 Dec 2018 07:13:08 -0500
Message-ID: <e37575905d14e9342bcecb8445ad730d57b4d713.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <nfs-ganesha-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/nfs-ganesha-devel>,
 <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=nfs-ganesha-devel>
List-Post: <mailto:nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs-ganesha-devel>,
 <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: nfs-ganesha-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ganesha NFS List <nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "support-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org" <support-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This list has been deprecated. Please subscribe to the new devel list at lists.nfs-ganesha.org.
(Sorry for the duplicate email to ganesha lists, but I wanted to widen
it to include the ceph lists)

In response to some cries for help over IRC, I wrote up this blog post
the other day, which discusses how to set up parallel serving over
CephFS:

    https://jtlayton.wordpress.com/2018/12/10/deploying-an-active-active-nfs-cluster-over-cephfs/

Feel free to comment if you have questions. We may be want to eventually
turn this into a document in the ganesha or ceph trees as well.

Cheers!
-- 
Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
