From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: convert comma to semicolon
Date: Thu, 24 Jul 2014 12:09:43 +0400
Message-ID: <CALFYKtBUjFnS6jH+wWUMTdgSohXNTewYWkM8atM8EiUHZ8=rzw@mail.gmail.com>
References: <20140723144111.GA3190@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140723144111.GA3190@himangi-Dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jul 23, 2014 at 6:41 PM, Himangi Saraogi <himangi774@gmail.com> wrote:
> Replace a comma between expression statements by a semicolon. This changes
> the semantics of the code, but given the current indentation appears to be
> what is intended.
>
> A simplified version of the Coccinelle semantic patch that performs this
> transformation is as follows:
> // <smpl>
> @r@
> expression e1,e2;
> @@
>
>  e1
> -,
> +;
>  e2;
> // </smpl>
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied.

Thanks,

                Ilya
