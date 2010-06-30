From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: =?windows-1252?Q?Re=3A_rbdtool=2Ecc_=3A_=91r=92_may_be_used_uninitialized_i?=
	=?windows-1252?Q?n_this_function?=
Date: Tue, 29 Jun 2010 22:40:17 -0700
Message-ID: <AANLkTinfwVADJjxvGURwHzOnRmjz9LLYWw5qyxOiSjXd@mail.gmail.com>
References: <i0el2n$usb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab0F3FkT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jun 2010 01:40:19 -0400
Received: by vws5 with SMTP id 5so579324vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jun 2010 22:40:17 -0700 (PDT)
In-Reply-To: <i0el2n$usb$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 29, 2010 at 10:35 PM, Thomas Mueller <thomas@chaschperli.ch=
> wrote:
>
> hi
>
> since today there is a new compiler warning:
>
> rbdtool.cc:180: warning: =91r=92 may be used uninitialized in this fu=
nction
>
> - Thomas

Thanks, pushed a fix.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
