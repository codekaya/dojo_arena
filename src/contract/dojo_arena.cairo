//DOJO ARENA
//@author kaya

use starknet::StorageAccess;
use starknet::StorageBaseAddress;
use starknet::SyscallResult;
use starknet::storage_access;
use starknet::storage_read_syscall;
use starknet::storage_write_syscall;
use starknet::storage_base_address_from_felt252;
use starknet::storage_address_from_base_and_offset;
use traits::Into;
use traits::TryInto;
use option::OptionTrait;

use starknet::contract_address_const;
use starknet::ContractAddress;

#[abi]
trait IERC20 {
    #[view]
    fn name() -> felt252;

    #[external]
    fn transferFrom(sender: ContractAddress, recipient: ContractAddress, amount: u256) -> bool;

    #[view]
    fn balanceOf(account: ContractAddress) -> u256;

    #[external]
    fn transfer(recipient: ContractAddress, amount: u256) -> bool;
}




#[derive(Copy, Drop, Serde)] 
struct Game {
    name: felt252,
    nft_collection_address: ContractAddress,
    turn_duration: u256,
    max_players: u16,
    num_players: u16,
    start_time: u256,
    initial_hp: u16,
    hunger_level: u16,
    is_active: bool,
    current_tour: u8,
    entry_fee : u256
    // creator: ContractAddress
}

#[derive(Copy, Drop, Serde)] 
struct Player {
    health: u16,
    name: felt252,
    pixel_heroes_id: u16,
    address: ContractAddress,
    nft_collection_address: ContractAddress,
    nft_collection_token_id: u16
    //move_made: bool,
    //is_dead: bool
}

#[derive(Copy, Drop, Serde)] 
struct Location {
    game_id: u256,
    player_id: u16
}

//const ETH_ADDRESS = 0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7 ;
// 0x05d28ab3eff3775b395ed163dae1bcd407171a95ade6b238bd27e6df61478b84

impl GameStorageAccess of StorageAccess::<Game> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult::<Game> {

        let name = StorageAccess::read(address_domain, base)?;

        let nft_collection_address_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 1_u8).into());
        let nft_collection_address = StorageAccess::read(address_domain, nft_collection_address_base)?;

        let turn_duration_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 2_u8).into());
        let turn_duration = StorageAccess::read(address_domain, turn_duration_base)?;

        let max_players_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 3_u8).into());
        let max_players = StorageAccess::read(address_domain, max_players_base)?;

        let num_players_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 4_u8).into());
        let num_players = StorageAccess::read(address_domain, num_players_base)?;

        let start_time_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 5_u8).into());
        let start_time = StorageAccess::read(address_domain, start_time_base)?;

        let initial_hp_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 6_u8).into());
        let initial_hp = StorageAccess::read(address_domain, initial_hp_base)?;

        let hunger_level_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 7_u8).into());
        let hunger_level = StorageAccess::read(address_domain, hunger_level_base)?;

        let is_active_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 8_u8).into());
        let is_active = StorageAccess::read(address_domain, is_active_base)?;

        let current_tour_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 9_u8).into());
        let current_tour = StorageAccess::read(address_domain, current_tour_base)?;

        let entry_fee_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 10_u8).into());
        let entry_fee = StorageAccess::read(address_domain, entry_fee_base)?;

        // let creator_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 11_u8).into());
        // let creator = StorageAccess::read(address_domain, creator_base)?;




        Result::Ok(Game { name , nft_collection_address, turn_duration, max_players, num_players, start_time, initial_hp, hunger_level, is_active, current_tour, entry_fee})

    }

    fn write(address_domain: u32, base: StorageBaseAddress, value: Game) -> SyscallResult::<()> {
        StorageAccess::write(address_domain, base, value.name)?;

        let nft_collection_address_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 1_u8).into());
        StorageAccess::write(address_domain, nft_collection_address_base, value.nft_collection_address)?;

        let turn_duration_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 2_u8).into());
        StorageAccess::write(address_domain, turn_duration_base, value.turn_duration)?;

        let max_players_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 3_u8).into());
        StorageAccess::write(address_domain, max_players_base, value.max_players)?;

        let num_players_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 4_u8).into());
        StorageAccess::write(address_domain, num_players_base, value.num_players)?;

        let start_time_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 5_u8).into());
        StorageAccess::write(address_domain, start_time_base, value.start_time)?;

        let initial_hp_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 6_u8).into());
        StorageAccess::write(address_domain, initial_hp_base, value.initial_hp)?;

        let hunger_level_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 7_u8).into());
        StorageAccess::write(address_domain, hunger_level_base, value.hunger_level)?;

        let is_active_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 8_u8).into());
        StorageAccess::write(address_domain, is_active_base, value.is_active)?;

        let current_tour_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 9_u8).into());
        StorageAccess::write(address_domain, current_tour_base, value.current_tour)?;

        let entry_fee_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 10_u8).into());
        StorageAccess::write(address_domain, entry_fee_base, value.entry_fee)

        // let creator_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 11_u8).into());
        // StorageAccess::write(address_domain, creator_base, value.creator)

    }
}

impl PlayerStorageAccess of StorageAccess::<Player> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult::<Player> {

        let health = StorageAccess::read(address_domain, base)?;

        let name_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 1_u8).into());
        let name = StorageAccess::read(address_domain, name_base)?;

        let pixel_heroes_id_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 2_u8).into());
        let pixel_heroes_id = StorageAccess::read(address_domain, pixel_heroes_id_base)?;

        let address_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 3_u8).into());
        let address = StorageAccess::read(address_domain, address_base)?;

        let nft_collection_address_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 4_u8).into());
        let nft_collection_address = StorageAccess::read(address_domain, nft_collection_address_base)?;

        let nft_collection_token_id_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 5_u8).into());
        let nft_collection_token_id = StorageAccess::read(address_domain, nft_collection_token_id_base)?;


        Result::Ok(Player {health, name, pixel_heroes_id, address, nft_collection_address, nft_collection_token_id})

    }

    fn write(address_domain: u32, base: StorageBaseAddress, value: Player) -> SyscallResult::<()> {
        StorageAccess::write(address_domain, base, value.health)?;

        let name_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 1_u8).into());
        StorageAccess::write(address_domain, name_base, value.name)?;

        let pixel_heroes_id_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 2_u8).into());
        StorageAccess::write(address_domain, pixel_heroes_id_base, value.pixel_heroes_id)?;

        let address_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 3_u8).into());
        StorageAccess::write(address_domain, address_base, value.address)?;

        let nft_collection_address_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 4_u8).into());
        StorageAccess::write(address_domain, nft_collection_address_base, value.nft_collection_address)?;

        let nft_collection_token_id_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 5_u8).into());
        StorageAccess::write(address_domain, nft_collection_token_id_base, value.nft_collection_token_id)

    }
}

impl LocationStorageAccess of StorageAccess::<Location> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult::<Location> {

        let game_id = StorageAccess::read(address_domain, base)?;

        let player_id_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 1_u8).into());
        let player_id = StorageAccess::read(address_domain, player_id_base)?;

        Result::Ok(Location {game_id, player_id})

    }

    fn write(address_domain: u32, base: StorageBaseAddress, value: Location) -> SyscallResult::<()> {
        StorageAccess::write(address_domain, base, value.game_id)?;

        let player_id_base = storage_base_address_from_felt252(storage_address_from_base_and_offset(base, 1_u8).into());
        StorageAccess::write(address_domain, player_id_base, value.player_id)

    }
}

#[contract]
mod dojo_arena {

    use starknet::ContractAddress;
    use starknet::StorageAccess;
    use starknet::get_contract_address;
    use starknet::get_caller_address;
    use starknet::contract_address_const;


    use super::IERC20DispatcherTrait;
    use super::IERC20Dispatcher;

    use super::Game;
    use super::Player;
    use super::Location;

    use openzeppelin::token::erc20::ERC20;
    use openzeppelin::access::ownable::Ownable;

    const MAX_HEALTH: u16 = 2400;


    struct Storage {
        games: LegacyMap::<u256, Game >,
        game_count: u256,
        players: LegacyMap::<(u256,u16), Player >,
        random_seed: u256,
        game_manager: ContractAddress,
        owner: ContractAddress
    }
    
    #[event]
    fn game_created(game_id: u256, game: Game , creator: ContractAddress) {}
    
    #[event]
    fn player_joined(game_id: u256, player_id: u16, player: Player, address: ContractAddress) {}

    #[event]
    fn move_made(game_id: u256, player_id: u256, address: ContractAddress) {}

    #[constructor]
    fn constructor() {
        game_count::write(0);
        //let address = get_caller_address();
        let address = contract_address_const::<0x00b42717976be9f43281e55e2420e6c41517cfd79076a7705fa3e91656d35bfb>();
        owner::write(address);
        //let supply = ERC20::_total_supply::read();
        //Ownable::initializer();
    }

    
    #[view]
    fn wen_dojo_arena() -> felt252 {
        return 'dojoarena coming ser!';
    }

    #[view]
    fn get_random_seed() -> u256 {
        return random_seed::read();
    }

    #[view]
    fn get_owner() -> ContractAddress {
        return owner::read();
    }


    #[view]
    fn get_game_manager() -> ContractAddress {
        return game_manager::read();
    }


    #[view]
    fn get_game_count() -> u256 {
        return game_count::read();
    }

    //get game
    #[view]
    fn get_game(game_id: u256) -> Game {
        return games::read(game_id);
    }

    #[view]
    fn get_player(game_id: u256,player_id: u16) -> Player {
        return players::read((game_id,player_id));
    }

    #[external]
    fn create_game(_name: felt252,
        _nft_collection_address: ContractAddress,
        _turn_duration: u256,
        _max_players: u16,
        _start_time: u256,
        _initial_hp: u16,
        _hunger_level: u16,
        _entry_fee:u256 ){
        
        let caller : ContractAddress= get_caller_address();

        let game = Game{
            name: _name,
            nft_collection_address: _nft_collection_address,
            turn_duration: _turn_duration,
            max_players: _max_players,
            num_players: 0,
            start_time: _start_time,
            initial_hp: _initial_hp,
            hunger_level: _hunger_level,
            is_active : true,
            current_tour: 0,
            entry_fee: _entry_fee
        };

        let _game_count = game_count::read();
        game_count::write(_game_count+1);
        let game_id = game_count::read();

        games::write(game_count::read(), game);

        game_created(game_id, game, caller);
        
    }

    #[external]
    fn join_game(game_id:u256,
        _name: felt252,
        _pixel_heroes_id: u16,
        _nft_collection_address: ContractAddress,
        _nft_collection_token_id: u16 ){
        
        let game = games::read(game_id);
        let _game_count = game_count::read();
        assert(game_id<=_game_count,'Invalid Game Id');
        assert(game_id>0, 'Invalid Game Id');
        let player = Player{
            health: MAX_HEALTH,
            name: _name,
            pixel_heroes_id: _pixel_heroes_id,
            address: get_caller_address(),
            nft_collection_address: _nft_collection_address,
            nft_collection_token_id: _nft_collection_token_id

        };
        let player_id = game.num_players + 1;
        let location = Location{game_id: 0, player_id: player_id};

        players::write((game_id,player_id), player);

        player_joined(game_id, player_id, player, get_caller_address());

        
    }

    #[external]
    fn set_game_manager(address : ContractAddress){
        let _owner = owner::read();
        assert(_owner == get_caller_address(), 'Caller is not owner');
        game_manager::write(address);

        // let sender : ContractAddress= get_caller_address();
        // let recipient : ContractAddress = get_contract_address();
        
        
        // let token_addr: ContractAddress = contract_address_const::<0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7>();
        // let success = IERC20Dispatcher { contract_address: token_addr }.transferFrom(sender, recipient, amount); 
    }

    #[external]
    fn withdraw(amount: u256){
        let recipient = owner::read();
        assert(recipient == get_caller_address(), 'Caller is not owner');
        let sender : ContractAddress = get_contract_address();
        
        
        let token_addr: ContractAddress = contract_address_const::<0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7>();
        let success = IERC20Dispatcher { contract_address: token_addr }.transfer(recipient, amount);

        assert(success, 'Transfer Failed');
    }

    #[external]
    fn withdraw_max(){
        let recipient = owner::read();
        assert(recipient == get_caller_address(), 'Caller is not owner');
        let sender : ContractAddress = get_contract_address();
        let token_addr: ContractAddress = contract_address_const::<0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7>();
        let amount = IERC20Dispatcher { contract_address: token_addr }.balanceOf(sender);
        let success = IERC20Dispatcher { contract_address: token_addr }.transfer(recipient, amount);
        assert(success, 'Transfer Failed');
    }


    // #[external]
    // fn hunt(game_id, player_id){



    // }

//------------------

    
    //contract issues need to be solved
    //easiest to hardest
    //first find erc721 end erc20 functions to implement
    //second find hash function to mapping
    //third fix randomness for now
    
    // #[external]
    // fn start_game(){
        
    // }

    // #[external]
    // fn end_game(){
        
    // }

    // #[external]
    // fn next_turn(){
        
    // }

 

    // #[external]
    // fn hide(){
        
    // }
    // #[external]
    // fn attack(){
        
    // }
   
    

    

}