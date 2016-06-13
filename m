From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: fix symbol versioning for ceph_monc_do_statfs
Date: Mon, 13 Jun 2016 15:19:12 +0200
Message-ID: <CAOi1vP9twC4r6wwuHV0FAcwBoYhELfdrLjjAfNDzMh==akKeJQ@mail.gmail.com>
References: <1465823125-171114-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36588 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423115AbcFMNTO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2016 09:19:14 -0400
In-Reply-To: <1465823125-171114-1-git-send-email-arnd@arndb.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Jan Beulich <jbeulich@suse.com>, Michal Marek <mmarek@suse.cz>, "Yan, Zheng" <zyan@redhat.com>, Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 13, 2016 at 3:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The genksyms helper in the kernel cannot parse a type definition
> like "typeof(((type *)0)->keyfld)" that is used in the DEFINE_RB_FUNCS
> helper, causing the following EXPORT_SYMBOL() statement to be ignored
> when computing the crcs, and triggering a warning about this:
>
> WARNING: "ceph_monc_do_statfs" [fs/ceph/ceph.ko] has no CRC
>
> To work around the problem, we can rewrite the type to reference
> an undefined 'extern' symbol instead of a NULL pointer. This is
> evidently ok for genksyms, and it no longer complains about the
> line when calling it with 'genksyms -w'.
>
> I've looked briefly into extending genksyms instead, but it seems
> really hard to do. Jan Beulich introduced basic support for 'typeof'
> a while ago in dc53324060f3 ("genksyms: fix typeof() handling"),
> but that is not sufficient for the expression we have here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: fcd00b68bbe2 ("libceph: DEFINE_RB_FUNCS macro")
> Cc: Jan Beulich <jbeulich@suse.com>
> Cc: Michal Marek <mmarek@suse.cz>
> ---
>  include/linux/ceph/libceph.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 690985daad1c..6b79a6ba39ca 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -214,8 +214,9 @@ static void erase_##name(struct rb_root *root, type *t)                     \
>  }
>
>  #define DEFINE_RB_LOOKUP_FUNC(name, type, keyfld, nodefld)             \
> +extern type __lookup_##name##_key;                                     \
>  static type *lookup_##name(struct rb_root *root,                       \
> -                          typeof(((type *)0)->keyfld) key)             \
> +                          typeof(__lookup_##name##_key.keyfld) key)    \
>  {                                                                      \
>         struct rb_node *n = root->rb_node;                              \
>                                                                         \

Out of curiosity, did you figure out why is it that only
ceph_monc_do_statfs() is affected and not the other exports in
net/ceph/osd_client.c?

Thanks,

                Ilya
