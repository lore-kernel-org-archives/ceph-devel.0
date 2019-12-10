From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: v14.2.5 Nautilus released
Date: Tue, 10 Dec 2019 14:32:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1912101432450.2897@piezo.novalocal>
References: <87sglscy4z.fsf@suse.com> <CAOi1vP8JyKzsc9mxHjMZWs_SaXQD7GrNbxRic9NvChxi_dUbow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CAOi1vP8JyKzsc9mxHjMZWs_SaXQD7GrNbxRic9NvChxi_dUbow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-announce-a8pt6IJUokc@public.gmane.org, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, dev-a8pt6IJUokc@public.gmane.org, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> >   If you are not comfortable sharing device metrics, you can disable that
> >   channel first before re-opting-in:
> >
> >     ceph config set mgr mgr/telemetry/channel_crash false
> 
> This should be channel_device, right?

Yep!

	https://github.com/ceph/ceph/pull/32148

Thanks,
sage
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
