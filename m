From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH] ceph: fix description of some mount options
Date: Tue, 11 Feb 2020 11:48:11 -0500
Message-ID: <537a2c4a37f601fe402fa7b893061fd9f4270f56.camel@kernel.org>
References: <20200211153120.21369-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200211153120.21369-1-xiubli@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: xiubli@redhat.com, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net
List-Id: ceph-devel.vger.kernel.org

On Tue, 2020-02-11 at 10:31 -0500, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Based on the latest code, the default value for wsize/rsize is
> 64MB and the default value for the mount_timeout is 60 seconds.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
> 
> Checked the history of the code, I am a little confused about the
> default values for wsize/rsize, there never been 16MB as the default,
> and for the mount_timeout, never seen 30 as default.
> 
> So did I miss something important about this ?
> 

It looks like the default rsize/wsize were 16M prior to 94e6992bb560b.
It then went to 32 and then 64 a little while afterward. I don't see
where the mount_timeout was ever 30s though.

Merged into testing branch since this seems obviously correct.

> 
>  Documentation/filesystems/ceph.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.txt
> index b19b6a03f91c..92ffc9b3b018 100644
> --- a/Documentation/filesystems/ceph.txt
> +++ b/Documentation/filesystems/ceph.txt
> @@ -103,17 +103,17 @@ Mount Options
>  	address its connection to the monitor originates from.
>  
>    wsize=X
> -	Specify the maximum write size in bytes.  Default: 16 MB.
> +	Specify the maximum write size in bytes.  Default: 64 MB.
>  
>    rsize=X
> -	Specify the maximum read size in bytes.  Default: 16 MB.
> +	Specify the maximum read size in bytes.  Default: 64 MB.
>  
>    rasize=X
>  	Specify the maximum readahead size in bytes.  Default: 8 MB.
>  
>    mount_timeout=X
>  	Specify the timeout value for mount (in seconds), in the case
> -	of a non-responsive Ceph file system.  The default is 30
> +	of a non-responsive Ceph file system.  The default is 60
>  	seconds.
>  
>    caps_max=X

-- 
Jeff Layton <jlayton@kernel.org>
