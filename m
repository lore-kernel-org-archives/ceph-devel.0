From: PanBian <bianpan2016@163.com>
Subject: Re: [PATCH] libceph: fix use after free
Date: Tue, 27 Nov 2018 17:09:52 +0800
Message-ID: <20181127090952.GA23643@bp>
References: <1543302127-14435-1-git-send-email-bianpan2016@163.com>
 <54c1bcc5-6df5-ba24-2774-98f6333c57b3@cogentembedded.com>
Reply-To: PanBian <bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54c1bcc5-6df5-ba24-2774-98f6333c57b3@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, DavidS.Miller@bp, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 27, 2018 at 11:47:56AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 27.11.2018 10:02, Pan Bian wrote:
> 
> >The function ceph_monc_handle_map calls kfree(old) to free the old
> >monitor map, old points to monc->monmap. However, after that, it reads
> >monc->monmap->epoch and passes it to __ceph_monc_got_map. This result in
> >a use-after-free bug. The patch moves the free operation after the call
> >to __ceph_monc_got_map.
> >
> >Fixes: 82dcabad750("libceph: revamp subs code, switch to SUBSCRIBE2
> 
>    Space needed before (.
> 
> >protocol")
> 
>    Never break up the commit summary in this tag.

Thanks for the guidance, I will correct it.

> 
> >Signed-off-by: Pan Bian <bianpan2016@163.com>
> [...]
> 
> MBR, Sergei
