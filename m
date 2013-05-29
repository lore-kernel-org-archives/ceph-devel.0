From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ceph: tidy ceph_mdsmap_decode() a little
Date: Wed, 29 May 2013 10:55:38 +0300
Message-ID: <20130529075538.GE23987@mwanda>
References: <20130529062213.GF23932@mwanda>
 <51A5AB81.5070908@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51A5AB81.5070908@bfs.de>
Sender: linux-kernel-owner@vger.kernel.org
To: walter harms <wharms@bfs.de>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On Wed, May 29, 2013 at 09:17:21AM +0200, walter harms wrote:
> personally i would go for:
> 		info->export_targets = NULL;
> and remove the else below.
> 

I don't have strong feelings one way or the other, but honestly, I
think the way I sent it is more clear.

regards,
dan carpenter
