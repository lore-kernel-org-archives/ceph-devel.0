From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/15] rbd: convert bus code to use bus_groups
Date: Tue, 27 Aug 2013 22:07:08 -0700
Message-ID: <20130828050708.GA15491@kroah.com>
References: <1377293081-10957-1-git-send-email-gregkh@linuxfoundation.org>
 <1377293081-10957-2-git-send-email-gregkh@linuxfoundation.org>
 <521C9D14.7090502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <521C9D14.7090502@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Elder <alex.elder@linaro.org>
Cc: linux-kernel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Aug 27, 2013 at 07:35:32AM -0500, Alex Elder wrote:
> On 08/23/2013 04:24 PM, Greg Kroah-Hartman wrote:
> > The bus_attrs field of struct bus_type is going away soon, dev_groups
> > should be used instead.  This converts the RBD bus code to use the
> > correct field.
> > 
> > Cc: Yehuda Sadeh <yehuda@inktank.com>
> > Cc: Sage Weil <sage@inktank.com>
> > Cc: Alex Elder <elder@inktank.com>
> 
> Looks reasonable to me.
> 
> Acked-by: Alex Elder <elder@linaro.org>

Thanks for the review.

greg k-h
