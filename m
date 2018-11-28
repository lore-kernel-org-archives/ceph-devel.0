From: PanBian <bianpan2016@163.com>
Subject: Re: [PATCH V2] libceph: fix use after free
Date: Wed, 28 Nov 2018 08:22:57 +0800
Message-ID: <20181128002257.GA38329@bp>
References: <1543310472-31861-1-git-send-email-bianpan2016@163.com>
 <CAOi1vP8Ff9HLF_v93RwyW4LwQ5jYPWPaZhqBgx9FsxmXH6M4AQ@mail.gmail.com>
Reply-To: PanBian <bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP8Ff9HLF_v93RwyW4LwQ5jYPWPaZhqBgx9FsxmXH6M4AQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 27, 2018 at 11:17:26AM +0100, Ilya Dryomov wrote:
> On Tue, Nov 27, 2018 at 10:22 AM Pan Bian <bianpan2016@163.com> wrote:
> >
> > The function ceph_monc_handle_map calls kfree(old) to free the old
> > monitor map, old points to monc->monmap. However, after that, it reads
> > monc->monmap->epoch and passes it to __ceph_monc_got_map. This will
> > result in a use-after-free bug. The patch moves the free operation after
> > the call to __ceph_monc_got_map.
> >
> > Fixes: 82dcabad750 ("libceph: revamp subs code, switch to SUBSCRIBE2 protocol")
> >
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> > V2: correct the format of the tag Fixes
> > ---
> >  net/ceph/mon_client.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > index 18deb3d..05ef5aa 100644
> > --- a/net/ceph/mon_client.c
> > +++ b/net/ceph/mon_client.c
> > @@ -478,9 +478,10 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
> >         }
> >
> >         client->monc.monmap = monmap;
> 
> monc->monmap is assigned here.  It's not obvious, but monc->monmap and
> client->monc.monmap is the same pointer.
> 
> > -       kfree(old);
> >
> >         __ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
> 
> ceph_monmap_decode() returns the new map, kfree() frees the old map.
> I don't see a use-after-free here.

Got it. Thank you!

Pan

> 
> Thanks,
> 
>                 Ilya
