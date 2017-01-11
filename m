From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD v1 image format ...
Date: Thu, 12 Jan 2017 02:01:59 +0900
Message-ID: <CAHX7ARuOZ=s5Vr9fHwSo7Sg6AvDq27gBpp7EGvOme8-W3C9DtQ@mail.gmail.com>
References: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jason Dillaman <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

It would be fine to not support v1 image format at all.

But it would be probably friendly for users to provide them with more
understandable message when they face feature mismatch instead of just
displaying:

 * rbd: map failed: (6) No such device or address

For instance, show the following something in message:

 * Execute rbd feature disable <image-name>
deep-flatten,fast-diff,object-map,exclusive-lock

 or

 * Set rbd default features to 3

What do you think?
Does it make sense to you?

Regards,


On Thu, Jan 12, 2017 at 1:09 AM, Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> I would like to propose that starting with the Luminous release of Ceph, RBD
> will no longer support the creation of v1 image format images via the rbd
> CLI and librbd.
>
> We previously made the v2 image format the default and deprecated the v1
> format under the Jewel release. It is important to note that we would still
> support the use of v1 images by the CLI, VMs, etc for Luminous.
>
> Any objections or concerns?
>
> --
> Jason
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
