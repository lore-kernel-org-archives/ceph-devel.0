From: Abhishek <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v14.2.1 Nautilus released
Date: Mon, 29 Apr 2019 21:18:06 +0200
Message-ID: <cbfed3591a3224536aa02f71ca469714@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

We're happy to announce the first bug fix release of Ceph Nautilus 
release series.
We recommend all nautilus users upgrade to this release. For upgrading 
from older releases of
ceph, general guidelines for upgrade to nautilus must be followed

Notable Changes
---------------

* The default value for `mon_crush_min_required_version` has been
   changed from `firefly` to `hammer`, which means the cluster will
   issue a health warning if your CRUSH tunables are older than hammer.
   There is generally a small (but non-zero) amount of data that will
   move around by making the switch to hammer tunables; for more 
information,
   see :ref:`crush-map-tunables`.

   If possible, we recommend that you set the oldest allowed client to 
`hammer`
   or later.  You can tell what the current oldest allowed client is 
with::

     ceph osd dump | min_compat_client

   If the current value is older than hammer, you can tell whether it
   is safe to make this change by verifying that there are no clients
   older than hammer current connected to the cluster with::

     ceph features

   The newer `straw2` CRUSH bucket type was introduced in hammer, and
   ensuring that all clients are hammer or newer allows new features
   only supported for `straw2` buckets to be used, including the
   `crush-compat` mode for the :ref:`balancer`.

* Ceph now packages python bindings for python3.6 instead of
   python3.4, because EPEL7 recently switched from python3.4 to
   python3.6 as the native python3. see the `announcement 
<https://lists.fedoraproject.org/archives/list/epel-announce-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org/message/EGUMKAIMPK2UD5VSHXM53BH2MBDGDWMO/>`_
   for more details on the background of this change.

Known Issues
------------

* Nautilus-based librbd clients cannot open images stored on 
pre-Luminous
   clusters


For a detailed changelog please refer to the official release notes
entry at the ceph blog 
https://ceph.com/releases/v14-2-1-nautilus-released/

Getting ceph:
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-14.2.1.tar.gz
* For packages, see
http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: d555a9489eb35f84f2e1ef49b77e19da9d113972
