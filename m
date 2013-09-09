From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] ceph: fscache support & upstream
	changes
Date: Mon, 09 Sep 2013 11:17:58 +0100
Message-ID: <13594.1378721878@warthog.procyon.org.uk>
References: <CANP1eJFtF7sRJkqg0xGqNjEzbz29GWywB8DAjfGFzDhCPSfjcg@mail.gmail.com>
	<cover.1378418255.git.milosz@adfin.com>
	<alpine.DEB.2.00.1309051555250.1073@cobra.newdream.net>
	<CANP1eJEk=eRmq1F+yYWB53spgifbU+zzKGdmKw6BGfx8SknkrA@mail.gmail.com>
	<18764.1378483142@warthog.procyon.org.uk>
	<CANP1eJFMdcsgSwVO9jhYQwn2C+19db1uy5=du7yYFbmiB6em0A@mail.gmail.com>
	<alpine.DEB.2.00.1309061302300.12830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <CANP1eJFtF7sRJkqg0xGqNjEzbz29GWywB8DAjfGFzDhCPSfjcg@mail.gmail.com>
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

> -               (1 << FSCACHE_OP_WAITING);
> +               (1 << FSCACHE_OP_WAITING) |
> +               (1 << FSCACHE_OP_UNUSE_COOKIE);

Yeah...  That'll do it.  We could just decrement n_active directly after
calling into the backend - after all, we cannot reduce n_active to 0 here
because the netfs cannot be calling fscache_relinquish_cookie() whilst also
calling this function - but this will do too.

David
