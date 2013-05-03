From: John Nielsen <lists-3ViXZUqnCrPk1uMJSBkQmQ@public.gmane.org>
Subject: Re: v0.56.5 released  --- not yet!
Date: Fri, 3 May 2013 13:50:28 -0600
Message-ID: <7BD87B47-BDD0-402C-91B9-791F2C675FBF@jnielsen.net>
References: <alpine.DEB.2.00.1305031111160.12472@cobra.newdream.net>
	<alpine.DEB.2.00.1305031225570.11013@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1305031225570.11013-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Will you please also bump the package revision number to e.g. 0.56.5-1.el6? That will make life easier for those of us who eagerly installed the update already by letting package managers do the right thing.

On May 3, 2013, at 1:26 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> We just discovered a problem with the sysvinit script and with mkcephfs. A 
> fix is building now, but in the meantime, hold off on this.  We've renamed 
> the repositories temporarily until a non-broken package is posted.
> 
> Thanks!
> sage
> 
> 
> On Fri, 3 May 2013, Sage Weil wrote:
> 
>> Behold, another Bobtail update!  This one serves three main purposes: it 
>> fixes a small issue with monitor features that is important when upgrading 
>> from argonaut -> bobtail -> cuttlefish, it backports many changes to the 
>> ceph-disk helper scripts that allow bobtail clusters to be deployed with 
>> the new ceph-deploy tool or our chef cookbooks, and it fixes several 
>> important bugs in librbd.  There is also, of course, the usual collection 
>> of important bug fixes in other parts of the system.
>> 
>> Notable changes include:
>> 
>> * mon: fix recording of quorum feature set (important for argonaut -> 
>>   bobtail -> cuttlefish mon upgrades)
>> * osd: minor peering bug fixes
>> * osd: fix a few bugs when pools are renamed
>> * osd: fix occasionally corrupted pg stats
>> * osd: fix behavior when broken v0.56[.0] clients connect
>> * rbd: avoid FIEMAP ioctl on import (it is broken on some kernels)
>> * librbd: fixes for several request/reply ordering bugs
>> * librbd: only set STRIPINGV2 feature on new images when needed
>> * librbd: new async flush method to resolve qemu hangs (requires Qemu 
>>   update as well)
>> * librbd: a few fixes to flatten
>> * ceph-disk: support for dm-crypt
>> * ceph-disk: many backports to allow bobtail deployments with 
>>   ceph-deploy, chef
>> * sysvinit: do not stop starting daemons on first failure
>> * udev: fixed rules for redhat-based distros
>> * build fixes for raring
>> 
>> For more detailed information, see the complete changelog.
>> 
>> You can get v0.56.5 from the usual places:
>> 
>> * Git at git://github.com/ceph/ceph.git
>> * Tarball at http://ceph.com/download/ceph-0.56.5.tar.gz
>> * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>> * For RPMs, see http://ceph.com/docs/master/install/rpm
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
