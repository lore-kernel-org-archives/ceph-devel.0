From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Failed to get omap key when mirroring of image is
 enabled
Date: Mon, 22 Jul 2019 08:06:45 -0400
Message-ID: <CA+aFP1BaKeK6QNhiV3dRr9JArsH3nxOuoOY4Tjdu=k_g6PdxyQ@mail.gmail.com>
References: <CAEbG6hHOe0Q8-dcgBxbW2GX+21BuETso9orZY-9sW37Y5rDwKQ@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEbG6hHOe0Q8-dcgBxbW2GX+21BuETso9orZY-9sW37Y5rDwKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, Jul 21, 2019 at 8:25 PM Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>  I have a rbd mirroring setup with primary and secondary clusters as peers and I have a pool enabled image mode.., In this i created a rbd image , enabled with journaling.
>
> But whenever i enable mirroring on the image,  I m getting error in osd.log. I couldnt trace it out. please guide me to solve this error.
>
> I think initially it worked fine. but after ceph process restart. these error coming
>
>
> Secondary.osd.0.log
>
> 2019-07-22 05:36:17.371771 7ffbaa0e9700  0 <cls> /build/ceph-12.2.12/src/cls/journal/cls_journal.cc:61: failed to get omap key: client_a5c76849-ba16-480a-a96b-ebfdb7f6ac65
> 2019-07-22 05:36:17.388552 7ffbaa0e9700  0 <cls> /build/ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set earlier than minimum: 0 < 1
> 2019-07-22 05:36:17.413102 7ffbaa0e9700  0 <cls> /build/ceph-12.2.12/src/cls/journal/cls_journal.cc:61: failed to get omap key: order
> 2019-07-22 05:36:23.341490 7ffbab8ec700  0 <cls> /build/ceph-12.2.12/src/cls/rbd/cls_rbd.cc:4125: error retrieving image id for global id '9e36b9f8-238e-4a54-a055-19b19447855e': (2) No such file or directory
>
>
> primary-osd.0.log
>
> 2019-07-22 05:16:49.287769 7fae12db1700  0 log_channel(cluster) log [DBG] : 1.b deep-scrub ok
> 2019-07-22 05:16:54.078698 7fae125b0700  0 log_channel(cluster) log [DBG] : 1.1b scrub starts
> 2019-07-22 05:16:54.293839 7fae125b0700  0 log_channel(cluster) log [DBG] : 1.1b scrub ok
> 2019-07-22 05:17:04.055277 7fae12db1700  0 <cls> /build/ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set earlier than minimum: 0 < 1
>
> 2019-07-22 05:33:21.540986 7fae135b2700  0 <cls> /build/ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set earlier than minimum: 0 < 1
> 2019-07-22 05:35:27.447820 7fae12db1700  0 <cls> /build/ceph-12.2.12/src/cls/rbd/cls_rbd.cc:4125: error retrieving image id for global id '8a61f694-f650-4ba1-b768-c5e7629ad2e0': (2) No such file or directory

Those don't look like errors, but the log level should probably be
reduced for those OSD cls methods. If you look at your rbd-mirror
daemon log, do you see any errors? That would be the important place
to look.

>
> --
> Regards,
> Ajitha R
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Jason
