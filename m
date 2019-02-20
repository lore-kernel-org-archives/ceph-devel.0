From: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Subject: Re: RBD image format v1 EOL ...
Date: Wed, 20 Feb 2019 10:22:47 +0100
Message-ID: <20190220092247.GZ92783@fi.muni.cz>
References: <CA+aFP1Dod_hwug_omfegFTERyiYmwa+3KDcBZsXcjR+B87YykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+aFP1Dod_hwug_omfegFTERyiYmwa+3KDcBZsXcjR+B87YykQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

	Hello,

Jason Dillaman wrote:
: For the future Ceph Octopus release, I would like to remove all
: remaining support for RBD image format v1 images baring any
: substantial pushback.
: 
: The image format for new images has been defaulted to the v2 image
: format since Infernalis, the v1 format was officially deprecated in
: Jewel, and creation of new v1 images was prohibited starting with
: Mimic.
: 
: The forthcoming Nautilus release will add a new image migration
: feature to help provide a low-impact conversion path forward for any
: legacy images in a cluster. The ability to migrate existing images off
: the v1 image format was the last known pain point that was highlighted
: the previous time I suggested removing support.
: 
: Please let me know if anyone has any major objections or concerns.

	If I read the parallel thread about pool migration in ceph-users@
correctly, the ability to migrate to v2 would still require to stop the client
before the "rbd migration prepare" can be executed.

	On my OpenNebula/Ceph cluster, I still have bigger tens of images
in v1 format, so it would induce a moderate pain to figure out which VMs
are using them, how availability-critical they are, and finally to migrate
the images.

	But whatever, I guess I can cope with it :-)

-Yenya

-- 
| Jan "Yenya" Kasprzak <kas at {fi.muni.cz - work | yenya.net - private}> |
| http://www.fi.muni.cz/~kas/                         GPG: 4096R/A45477D5 |
 This is the world we live in: the way to deal with computers is to google
 the symptoms, and hope that you don't have to watch a video. --P. Zaitcev
