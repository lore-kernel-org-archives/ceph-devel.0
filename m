From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/8] ceph: fscache support & upstream
	changes
Date: Fri, 6 Sep 2013 13:03:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309061302300.12830@cobra.newdream.net>
References: <cover.1378418255.git.milosz@adfin.com>
	<alpine.DEB.2.00.1309051555250.1073@cobra.newdream.net>
	<CANP1eJEk=eRmq1F+yYWB53spgifbU+zzKGdmKw6BGfx8SknkrA@mail.gmail.com>
	<18764.1378483142@warthog.procyon.org.uk>
	<CANP1eJFMdcsgSwVO9jhYQwn2C+19db1uy5=du7yYFbmiB6em0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJFMdcsgSwVO9jhYQwn2C+19db1uy5=du7yYFbmiB6em0A@mail.gmail.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, sprabhu@redhat.com, "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, 6 Sep 2013, Milosz Tanski wrote:
> Sage,
> 
> I've taken David's latest changes and per his request merged his
> 'fscache-fixes-for-ceph' tag then applied my changes on top of that.
> In addition to the pervious changes I also added a fix for the
> warnings the linux-next build bot found.
> 
> I've given the results a quick test to make sure it builds, boots and
> runs okay. The code is located in my repository:
> 
>   https://adfin@bitbucket.org/adfin/linux-fs.git in the wip-fscache-v2 branch
> 
> I hope that this is the final go for now and thanks for everyone's patience.

Looks good; I'll send this to Linus along with the other ceph patches 
shortly.

Thanks, everyone!
sage


> 
>  - Milosz
> 
> On Fri, Sep 6, 2013 at 11:59 AM, David Howells <dhowells@redhat.com> wrote:
> > Milosz Tanski <milosz@adfin.com> wrote:
> >
> >> After running this for a day on some loaded machines I ran into what
> >> looks like an old issue with the new code. I remember you saw an issue
> >> that manifested it self in a similar way a while back.
> >>
> >> [13837253.462779] FS-Cache: Assertion failed
> >> [13837253.462782] 3 == 5 is false
> >> [13837253.462807] ------------[ cut here ]------------
> >> [13837253.462811] kernel BUG at fs/fscache/operation.c:414!
> >
> > Bah.
> >
> > I forgot to call fscache_op_complete().  Patch updated and repushed.
> >
> > Btw, I've reordered the patches to put the CIFS patch last.  Can you merge the
> > patches prior to the CIFS commit from my branch rather than cherry picking
> > them so that if they go via two different routes, GIT will handle the merge
> > correctly?  I've stuck a tag on it (fscache-fixes-for-ceph) to make that
> > easier for you.
> >
> > I've also asked another RH engineer to try doing some basic testing on the
> > CIFS stuff - which may validate the fscache_readpages_cancel patch.
> >
> > David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
