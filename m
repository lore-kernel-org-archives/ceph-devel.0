From: Andy Grover <agrover@redhat.com>
Subject: Re: [PATCH 12/18] target: compare and write backend driver sense
 handling
Date: Fri, 4 Sep 2015 15:34:21 -0700
Message-ID: <55EA1C6D.6020201@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
 <1438161835-27960-12-git-send-email-mchristi@redhat.com>
 <55E9F3DC.1010404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <55E9F3DC.1010404@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: Mike Christie <mchristi@redhat.com>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 09/04/2015 12:41 PM, Mike Christie wrote:
> Hey Nick and Christoph,
>
> For the target_core_iblock + rbd/COMPARE_AND_WRITE support approach, I
> still need a patch like below to be able to allow target_core_iblock.c
> to be able to specify specific codes like TCM_MISCOMPARE_VERIFY.
>
> Is the patch below ok? I made it work similar to how we have other
> completion functions, target_complete_cmd_with_*, that take in extra
> amounts of info like length or sense.
>
> Instead, I can modify target_complete_cmd and all the callers so they
> just take/pass the sense and info if needed:
>
> void target_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
> 			 sense_reason_t sense, u32 info)

We also want user/pscsi passthrough to be able to return correct sense 
info, and your patch would let them do this.

-- Andy
