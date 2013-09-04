From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/5] new fscache interface to check
	cache consistency
Date: Wed, 04 Sep 2013 19:13:20 +0100
Message-ID: <16226.1378318400@warthog.procyon.org.uk>
References: <CANP1eJEo_dNyYU+ZdvrwKfFPihig9m-Yf_-bUoXym-MF5bGnQg@mail.gmail.com>
	<cover.1375999914.git.milosz@adfin.com>
	<306cbe63f85921ad40b00e3c7071be19cb6adf04.1375999914.git.milosz@adfin.com>
	<18832.1378311843@warthog.procyon.org.uk>
	<CANP1eJFKGD_h6rcWMWpxp3yOD+rz6p2P0B+2CTcy1taDwM9rdg@mail.gmail.com>
	<18284.1378315570@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJEo_dNyYU+ZdvrwKfFPihig9m-Yf_-bUoXym-MF5bGnQg@mail.gmail.com>
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
Cc: Sage Weil <sage@inktank.com>, linux-kernel@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, "Yan,
	Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Milosz Tanski <milosz@adfin.com> wrote:

> Is it as simple as stick a mutex at the top of the
> __fscache_check_consistency function before we try to find the object?

You can lock a mutex in a function, but where are you actually going to place
the mutex struct?  And what other code is going to take it?  To do this, you'd
have to place the mutex struct in fscache_cookie.  The problem is that you
have to protect the pointer from fscache_cookie to fscache_object - so placing
the mutex in fscache_object doesn't help.

David
