From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/9] gpiolib: devres: use correct structure type name in sizeof
Date: Fri, 8 Aug 2014 15:26:59 +0200
Message-ID: <CACRpkdZBuihe8dy3WhM9n0xqjBDV_5w+cVd6VL_xWWERuxRCrg@mail.gmail.com>
References: <1406647011-8543-1-git-send-email-Julia.Lawall@lip6.fr>
	<1406647011-8543-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1406647011-8543-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-ia64-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-ia64@vger.kernel.org, ceph-devel@vger.kernel.org, toralf.foerster@gmx.de, hmh@hmh.eng.br, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 29, 2014 at 5:16 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Correct typo in the name of the type given to sizeof.  Because it is the
> size of a pointer that is wanted, the typo has no impact on compilation or
> execution.
>
> This problem was found using Coccinelle (http://coccinelle.lip6.fr/).  The
> semantic patch used can be found in message 0 of this patch series.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied with Alexandre's ACK.

Yours,
Linus Walleij
