From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/4] ext4: Remove unnecessary check for APPEND and
 IMMUTABLE
Date: Sat, 12 Apr 2014 09:48:15 -0400
Message-ID: <20140412134815.GA13837@thunk.org>
References: <1397242665-2183-1-git-send-email-lczerner@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ext4-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397242665-2183-1-git-send-email-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, xfs@oss.sgi.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 11, 2014 at 08:57:42PM +0200, Lukas Czerner wrote:
> All the checks IS_APPEND and IS_IMMUTABLE for the fallocate operation on
> the inode are done in vfs. No need to do this again in ext4. Remove it.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Thanks, applied.

					- Ted
