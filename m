From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: RBD image format v1 EOL ...
Date: Wed, 13 Feb 2019 13:36:53 -0500
Message-ID: <CA+aFP1Dod_hwug_omfegFTERyiYmwa+3KDcBZsXcjR+B87YykQ@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

For the future Ceph Octopus release, I would like to remove all
remaining support for RBD image format v1 images baring any
substantial pushback.

The image format for new images has been defaulted to the v2 image
format since Infernalis, the v1 format was officially deprecated in
Jewel, and creation of new v1 images was prohibited starting with
Mimic.

The forthcoming Nautilus release will add a new image migration
feature to help provide a low-impact conversion path forward for any
legacy images in a cluster. The ability to migrate existing images off
the v1 image format was the last known pain point that was highlighted
the previous time I suggested removing support.

Please let me know if anyone has any major objections or concerns.

Thanks,
Jason
