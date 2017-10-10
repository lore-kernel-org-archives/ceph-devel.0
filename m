From: Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Subject: Re: ceph-volume: migration and disk partition support
Date: Tue, 10 Oct 2017 09:28:31 +0200
Message-ID: <20171010072831.GB20633@shell.dmz.bit.nl>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Quoting Alfredo Deza (adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org):
> Hi,
> 
> Now that ceph-volume is part of the Luminous release, we've been able
> to provide filestore support for LVM-based OSDs. We are making use of
> LVM's powerful mechanisms to store metadata which allows the process
> to no longer rely on UDEV and GPT labels (unlike ceph-disk).
> 
> Bluestore support should be the next step for `ceph-volume lvm`, and
> while that is planned we are thinking of ways to improve the current
> caveats (like OSDs not coming up) for clusters that have deployed OSDs
> with ceph-disk.

I'm a bit confused after reading this. Just to make things clear. Would
bluestore be put on top of a LVM volume (in an ideal world)? Has
bluestore in Ceph luminious support for LVM? I.e. is there code in
bluestore to support LVM? Or is it _just_ support of `ceph-volume lvm`
for bluestore?

> --- New clusters ---
> The `ceph-volume lvm` deployment is straightforward (currently
> supported in ceph-ansible), but there isn't support for plain disks
> (with partitions) currently, like there is with ceph-disk.
> 
> Is there a pressing interest in supporting plain disks with
> partitions? Or only supporting LVM-based OSDs fine?

We're still in a green field situation. Users with an installed base
will have to comment on this. If the assumption that bluestore would be
put on top of LVM is true, it would make things simpler (in our own Ceph
ansible playbook).

Gr. Stefan

-- 
| BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
| GPG: 0xD14839C6                   +31 318 648 688 / info-68+x73Hep80@public.gmane.org
