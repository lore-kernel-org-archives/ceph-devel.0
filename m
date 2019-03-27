From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH] ceph: Convert to fs_context
Date: Wed, 27 Mar 2019 10:10:32 +0000
Message-ID: <2235.1553681432@warthog.procyon.org.uk>
References: <CAAM7YAnsYr0uQixmcv-=UDLWdmdJmbEN2D_zBcFQq2j-s+xtiw@mail.gmail.com> <155309339693.2324.9941108136967815885.stgit@warthog.procyon.org.uk> <155309340402.2324.7571102623113278534.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAnsYr0uQixmcv-=UDLWdmdJmbEN2D_zBcFQq2j-s+xtiw@mail.gmail.com>
Content-ID: <2234.1553681432.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: dhowells@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Yan, Zheng <ukernel@gmail.com> wrote:

> > -       if (fsopt->sb_flags != other->mount_options->sb_flags) {
> > +       if (fc->sb_flags != sb->s_flags) {

Fixed with:

@@ -945,7 +945,7 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 		dout("fsid doesn't match\n");
 		return 0;
 	}
-	if (fc->sb_flags != sb->s_flags) {
+	if (fc->sb_flags != (sb->s_flags & ~SB_BORN)) {
 		dout("flags differ\n");
 		return 0;
 	}

David
