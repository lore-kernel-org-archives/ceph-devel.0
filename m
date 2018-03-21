From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] block: rbd: update sysfs interface
Date: Wed, 21 Mar 2018 09:21:03 -0600
Message-ID: <20180321092103.786a4db8@lwn.net>
References: <20180223101959.GA4441@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223101959.GA4441@mordor.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Fri, 23 Feb 2018 15:49:59 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> The existing sysfs interface has been updated to be in the same format
> as described in Documentation/ABI/README. This will be useful for
> scripting and tracking changes in the ABI. Attributes have been grouped
> by functionality and/or the date on which they were added.
> 
> There are a couple of more changes:
> - The attributes have been annotated with file permissions RO/RW/WO.
> - Added description of the bus attribute supported_features

I've applied this one to the docs tree, thanks.

jon
