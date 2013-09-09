From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] ceph: fscache support & upstream
	changes
Date: Mon, 09 Sep 2013 11:18:52 +0100
Message-ID: <13625.1378721932@warthog.procyon.org.uk>
References: <CANP1eJF9oyfTWL1up38cEFyQFZQU51v1Yo1wZqFYxN2qkvc7gQ@mail.gmail.com>
	<cover.1378418255.git.milosz@adfin.com>
	<alpine.DEB.2.00.1309051555250.1073@cobra.newdream.net>
	<CANP1eJEk=eRmq1F+yYWB53spgifbU+zzKGdmKw6BGfx8SknkrA@mail.gmail.com>
	<18764.1378483142@warthog.procyon.org.uk>
	<CANP1eJFMdcsgSwVO9jhYQwn2C+19db1uy5=du7yYFbmiB6em0A@mail.gmail.com>
	<alpine.DEB.2.00.1309061302300.12830@cobra.newdream.net>
	<CANP1eJFtF7sRJkqg0xGqNjEzbz29GWywB8DAjfGFzDhCPSfjcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJF9oyfTWL1up38cEFyQFZQU51v1Yo1wZqFYxN2qkvc7gQ@mail.gmail.com>
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
Cc: Sage Weil <sage@inktank.com>, linux-kernel@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, sprabhu@redhat.com, "Yan,
	Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Milosz Tanski <milosz@adfin.com> wrote:

> I think that change does the trick. I had it running on the same
> machine for 5 hours and had the kernel forcefully drop some of the
> inodes in the cache (via drop caches) without a crash. I'll send a
> proper patch email after you take a look and make sure I did the right
> thing.

Do you mind if I roll your change directly into my patch and reissue the set?
Or would you rather have an extra patch at this time?

David
