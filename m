From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] block: rbd: constify rbd_attr_group and rbd_opts_tokens
Date: Thu, 22 Jun 2017 05:23:00 -0700
Message-ID: <1498134180.24295.2.camel@perches.com>
References: <a70b3cd481092b32ea362a885c4a54c4f50118e2.1498132969.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a70b3cd481092b32ea362a885c4a54c4f50118e2.1498132969.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, idryomov@gmail.com, sage@redhat.com, elder@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2017-06-22 at 17:34 +0530, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   43100	   2161	     64	  45325	   b10d	drivers/block/rbd.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   43292	   1969	     64	  45325	   b10d	drivers/block/rbd.o

If you are going to do these conversions, I still think
it'd be better to use a standard struct declaration.

From 2011, (const was also added)
http://lkml.iu.edu/hypermail/linux/kernel/1104.2/00738.html
