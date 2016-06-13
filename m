From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ceph: fix symbol versioning for ceph_monc_do_statfs
Date: Mon, 13 Jun 2016 16:59:49 +0200
Message-ID: <5230458.e005FX3QRC@wuerfel>
References: <1465823125-171114-1-git-send-email-arnd@arndb.de> <CAOi1vP9twC4r6wwuHV0FAcwBoYhELfdrLjjAfNDzMh==akKeJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP9twC4r6wwuHV0FAcwBoYhELfdrLjjAfNDzMh==akKeJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Jan Beulich <jbeulich@suse.com>, Michal Marek <mmarek@suse.cz>, "Yan, Zheng" <zyan@redhat.com>, Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Monday, June 13, 2016 3:19:12 PM CEST Ilya Dryomov wrote:
> > diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> > index 690985daad1c..6b79a6ba39ca 100644
> > --- a/include/linux/ceph/libceph.h
> > +++ b/include/linux/ceph/libceph.h
> > @@ -214,8 +214,9 @@ static void erase_##name(struct rb_root *root, type *t)                     \
> >  }
> >
> >  #define DEFINE_RB_LOOKUP_FUNC(name, type, keyfld, nodefld)             \
> > +extern type __lookup_##name##_key;                                     \
> >  static type *lookup_##name(struct rb_root *root,                       \
> > -                          typeof(((type *)0)->keyfld) key)             \
> > +                          typeof(__lookup_##name##_key.keyfld) key)    \
> >  {                                                                      \
> >         struct rb_node *n = root->rb_node;                              \
> >                                                                         \
> 
> Out of curiosity, did you figure out why is it that only
> ceph_monc_do_statfs() is affected and not the other exports in
> net/ceph/osd_client.c?

No, I did not investigate it further at that point. My guess is that
something resets the state of the genksyms parser when it encounters
some tokens (like the semicolon I added earlier, or an EXPORT_SYMBOL
statement), and that this happens in one file but not the other.

	Arnd
