From: "=?ISO-8859-15?Q?Steffen=20Wei=DFgerber?=" <WeissgerberS-Srp0Ujq4vxI@public.gmane.org>
Subject: Antw:  Ceph : Generic Query : Raw Format of images
Date: Thu, 21 Jul 2016 10:03:47 +0200
Message-ID: <57909E03020000CD0002C3A0@mail.dbknb.de>
References: <CANba6BaNu7qCmd3NpU2Yc4uMpRc_Za28WL4L0BKFr=1ars+CNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANba6BaNu7qCmd3NpU2Yc4uMpRc_Za28WL4L0BKFr=1ars+CNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: er.gauravgoyal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org




>>> Gaurav Goyal <er.gauravgoyal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> schrieb am Mittwoch, 20. Juli 2016 um
17:41:
> Dear Ceph User,
> 

Hi,

> I want to ask a very generic query regarding ceph.
> 
> Ceph does use .raw format. But every single company is providing qcow2
> images.
> It takes a lot of time to convert the images to raw format.
> 
> is it something everyone else is dealing with?
> Or i am not doing something right.
> 

Maybe you mean:
"...
The raw data format is really the only sensible format option to use with RBD.
Technically, you could use other QEMU-supported formats (such as qcow2 or vmdk),
but doing so would add additional overhead, and would also render the volume
unsafe for virtual machine live migration when caching (see below) is enabled. "
(http://docs.ceph.com/docs/hammer/rbd/qemu-rbd/)

> Specially when Organization know ceph functionality, why dont they create
> raw images along with qcow2.
> 

Maybe because they start to configure the qemu vm's based on disk files and
want to use qcow features.

If you get an image file from external the normal way to put into a ceph cluster
for qemu is qemu-convert. Is the difference between convert from raw-to-raw
to qcow2-to-raw that big?

> 
> Regards
> Gaurav Goyal

Regards

Steffen


-- 
Klinik-Service Neubrandenburg GmbH
Allendestr. 30, 17036 Neubrandenburg
Amtsgericht Neubrandenburg, HRB 2457
Geschaeftsfuehrerin: Gudrun Kappich
