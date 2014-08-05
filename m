From: David Howells <dhowells@redhat.com>
Subject: Re: fscache recursive hang -- similar to loopback
	NFS issues
Date: Tue, 05 Aug 2014 15:32:46 +0100
Message-ID: <20765.1407249166@warthog.procyon.org.uk>
References: <CANP1eJGoT2RmKB6asjbFgP=emLuxQqgqE4Xf9Gx7fYzPfS1img@mail.gmail.com>
	<CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
	<CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
	<29057.1406650354@warthog.procyon.org.uk>
	<20140730071735.21ab7ca6@notabene.brown>
	<CANP1eJHo7xrFoXWWgKQNrTi94vaxN9x-ViXNBE4VcXAa_jjQ3Q@mail.gmail.com>
	<20140730121935.124bc7c9@notabene.brown>
	<CANP1eJEBO0VbG2MoBzRB1h3c0QzOhAjvqUtHSX0+Y_uDT5oZug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJGoT2RmKB6asjbFgP=emLuxQqgqE4Xf9Gx7fYzPfS1img@mail.gmail.com>
Content-ID: <20764.1407249166.1@warthog.procyon.org.uk>
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
Cc: NeilBrown <neilb@suse.de>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

Milosz Tanski <milosz@adfin.com> wrote:

> FSCache already tracks statistics about how long writes and reads take
> (at least if you enable that option). With those stats in hand we
> should be able generate a default timeout value that works well and
> avoid a tunable.

If stat generation is going to be on all the time, it should probably use
something other than atomic ops.  NFS uses a set of ints on each CPU which are
added together when needed.

David
