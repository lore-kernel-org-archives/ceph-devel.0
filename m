From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 5 Aug 2013 14:12:13 +0300
Message-ID: <20130805111213.GM2924@reaktio.net>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au>
	<CAF6-1L6OrfOQssCWFqQL7KXTvMy+SyCd1XNrfme80p_7EEHj=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAF6-1L6OrfOQssCWFqQL7KXTvMy+SyCd1XNrfme80p_7EEHj=Q@mail.gmail.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Harper <james.harper@bendigoit.com.au>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Aug 05, 2013 at 01:01:35PM +0200, Sylvain Munaut wrote:
> 
> > Any chance this will be rolled into the main blktap sources?
> 
> I'd like to ... but I ave no idea how or even who to contact for that
> ... blktap is so fragmented ...
> 
> You have blktap2 which is in the man Xen tree. But that's not what's
> used in debian (it's not installed / compiled)
> 
> You have the so called blktap2.5 which is what's on github and what I
> have based my stuff on. It's also what's shipped with debian as
> blktap-utils I think.
> I also think Citrix have their own version based off blktap2.5 as well.
>

Yep, XenServer is using blktap2.5. 

Also the Centos-6 Xen packages have blktap2.5 patched in.
 
> And soon there will be blktap3 in the official Xen tree.
> 
> I want to at least get it merged in blktap3 but since that code is not
> ready (or even merged) yet, it's a bit early for that. That's also
> probably Xen 4.4 or Xen 4.5 stuff and so won't hit debian for a while.
> 

I think I saw an announcement recently on xen-devel that blktap3 development has been stopped.. 


-- Pasi
