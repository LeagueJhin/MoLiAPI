export interface Song {
	id: number;
	name: string;
	thirdId: number;
	albumId: number;
	playlistId: number;
	artists?: string;
	picUrl: string;
	publishTime: Date;
	type: string;
	nickname: string;
}
