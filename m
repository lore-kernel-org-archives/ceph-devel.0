From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCHv4 0/5] ceph: persistent caching with
	fscache
Date: Wed, 4 Sep 2013 08:54:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309040851080.27503@cobra.newdream.net>
References: <alpine.DEB.2.00.1308212203320.1479@cobra.newdream.net>
	<cover.1375999914.git.milosz@adfin.com>
	<17341.1378309753@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <17341.1378309753@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi David!

On Wed, 4 Sep 2013, David Howells wrote:
> Sage Weil <sage@inktank.com> wrote:
> 
> > David, are the fscache patches here ready for the next merge window?  Do 
> > you have a preference for whose tree they go through?
> 
> There's only one problem - patch 1 needs to come _after_ patch 2 to avoid
> breaking git bisect.  Plus these patches 2 and 4 extend the fscache API
> without adjusting the documentation - but that can be added later.
> 
> And I think Milosz deserves a beer (or other poison of his choice;-) for
> finding a longstanding irritating bug.
> 
> I think AFS, CIFS, NFS and 9P all need patching too, but I can attend to that.
> 
> Should I take the patches through my tree?  Then I can make the adjustments.

Sure.  Do you want the Ceph patches as well, or just the fscache bits?  
I'll repost the latest version, as it's gotten several fixes squashed in.

Thanks!
sage
